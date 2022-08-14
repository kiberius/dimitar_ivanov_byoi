resource "aws_eip" "main" {
  tags = {
    Name        = var.Name
    Deployment  = "Terraform"
    Environment = "Sandbox"
  }
}