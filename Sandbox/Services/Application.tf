resource "aws_launch_template" "LT-sandbox" {
  name = "Launch_Template-sandbox"
  iam_instance_profile {
    arn = aws_iam_instance_profile.iam-instance-profile.arn
  }
  block_device_mappings {
    device_name = "/dev/xvda"
    ebs {
      volume_size = 10
    }
  }
  image_id      = data.aws_ami.AmazonAMI.id
  instance_type = "t3.medium"
  monitoring {
    enabled = true
  }
  vpc_security_group_ids = [data.aws_security_group.app.id]
  tag_specifications {
    resource_type = "instance"
    tags = {
      Name        = "ASG-sandbox"
      Deployment  = "Terraform"
      Environment = "Sandbox"
    }
  }
  key_name  = "asg-key"
  user_data = base64encode(data.template_file.wp-template.rendered)
  tags = {
    Name = "Launch_Template-sandbox"
  }
}

resource "aws_autoscaling_group" "auto_scaling_group-sandbox" {
  name                = "ACG-sandbox"
  vpc_zone_identifier = data.aws_subnet_ids.app.ids
  health_check_type   = "ELB"
  desired_capacity    = 2
  max_size            = 2
  min_size            = 2
  target_group_arns   = [aws_lb_target_group.main.arn]
  depends_on          = [aws_db_instance.db_instance-sandbox]
  launch_template {
    id      = aws_launch_template.LT-sandbox.id
    version = "$Latest"
  }
  tag {
    key                 = "Deployment"
    propagate_at_launch = true
    value               = "Terraform"
  }
  tag {
    key                 = "Environment"
    propagate_at_launch = true
    value               = "Sandbox"
  }
}

resource "aws_autoscaling_attachment" "asg_attachment-sandbox" {
  autoscaling_group_name = aws_autoscaling_group.auto_scaling_group-sandbox.name
  alb_target_group_arn   = aws_lb_target_group.main.arn
}

resource "aws_key_pair" "ASG-key-pair" {
  key_name   = "asg-key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDb0VWazj3tHASR/f3Y0F6pVtSHvAmZzqb+tc4q1MOJhlzD++QF1OYUkKQIpjmLoDgyeARG78hsjt4FQIEIIuQVtPCFKi697MUSWF2/n3YlVaVSpHw8sq738p5e1NAoXBMng2dj5l7vOi/jxTCg+Tj1w3Bp4h5MFd9cGsw4ltpqXBB1XPSQoXf/tPrRLc12JxRmmlKxepOZGki0DrB9jKEDlNxqz5sXLYkoDjSTjPjOJr9IYUkxV4BHuRLqxrBNN/8JruxKc/LHDM22f0byfmBN8nFU4tIB3MaEIYLO/I1zIngXn5J8CqGuuWee8I/undXhoAIuB78an+yyiNgdbSeP ec2-user@ip-10-0-1-21.eu-west-1.compute.internal"
}

resource "aws_s3_bucket_object" "wp-config" {
  bucket = "tfstate-bucket-dimitarivanov-sandbox"
  key    = "wp-config.php"
  source = "./wp-config.php"
}

resource "aws_s3_bucket_object" "cw-config" {
  bucket = "tfstate-bucket-dimitarivanov-sandbox"
  key    = "cw_config.json"
  source = "./Services-Policies/cw_config.json"
}

data "template_file" "wp-template" {
  template = file("${path.module}/user_data.sh.tmpl")
  vars = {
    db_endpoint    = aws_db_instance.db_instance-sandbox.endpoint
    db_user        = var.db_user
    db_pass        = var.db_pass
    db_name        = var.db_name
    dns_name       = var.dns_name
    wp_site_title  = var.wp_site_title
    wp_admin_user  = var.wp_admin_user
    wp_admin_pass  = var.wp_admin_pass
    wp_admin_email = var.wp_admin_email
  }
}