resource "aws_security_group" "main" {
  name        = var.Name
  description = var.description
  vpc_id      = var.vpc_id
  tags = {
    Name        = var.Name
    IaC         = "Terraform"
    Environment = "Dev"
  }
}