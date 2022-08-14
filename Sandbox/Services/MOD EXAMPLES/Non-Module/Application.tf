#### DATA USED ####
data "aws_vpc" "main" {
  tags = {
    Name = "VPC-dimitarivanov-sandbox"
  }
}

data "aws_security_group" "application" {
  tags = {
    Name = "Application Instances SG"
  }
}

#### APPLICATION ####
resource "aws_launch_template" "launch_template-sandbox" {
  name = "Launch_Template-sandbox"
  block_device_mappings {
    device_name = "/dev/sda1"
    ebs {
      volume_size = 20
    }
  }
  image_id                             = "ami-063d4ab14480ac177"
  instance_initiated_shutdown_behavior = "stop"
  instance_type                        = "t2.micro"
  key_name                             = "testings"
  vpc_security_group_ids               = [data.aws_security_group.application.id]
  iam_instance_profile {
    arn = aws_iam_instance_profile.iam_instance_profile-dimitarivanov-sandbox_eu-west-1.arn
  }
  tag_specifications {
    resource_type = "instance"
    tags = {
      Name        = "App_Instances-Launch_Template-sandbox"
      IaC         = "Terraform"
      Environment = "Sandbox"
    }
  }

  user_data = filebase64("../../../Scripts/wp_user_data.sh")
}