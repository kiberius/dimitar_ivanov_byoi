resource "aws_route_table" "main" {
  vpc_id = data.aws_vpc.main.id
  tags = {
    Name        = var.Name
    IaC         = "Terraform"
    Environment = "Dev"
  }
}