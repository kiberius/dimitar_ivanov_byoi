resource "aws_instance" "bastion" {
  ami                         = data.aws_ami.AmazonAMI.id
  instance_type               = "t3.micro"
  subnet_id                   = data.aws_subnet.bastion-subnet.id
  security_groups             = [data.aws_security_group.bastion.id]
  key_name                    = "asg-key"
  user_data                   = file("./bastion_script.sh")
  associate_public_ip_address = true
  iam_instance_profile        = aws_iam_instance_profile.iam-instance-profile.name
  tags = {
    Name        = "bastion"
    Deployment  = "Terraform"
    Environment = "Sandbox"
  }
}

## Use command in bastion to download ssh key from S3 for access to ASG instances:
## aws s3 cp s3://tfstate-bucket-dimitarivanov-sandbox/asg-key.pem ~/app-key/asg-key.pem