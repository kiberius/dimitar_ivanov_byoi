resource "aws_lb" "main" {
  name               = var.Name
  internal           = false
  load_balancer_type = "application"
  security_groups    = var.security_groups
  subnets            = var.subnets
  tags = {
    Name        = var.Name
    IaC         = "Terraform"
    Environment = "Dev"
  }
}