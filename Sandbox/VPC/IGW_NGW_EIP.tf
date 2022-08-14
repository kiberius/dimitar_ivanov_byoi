#### IGW ####
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name        = "IGW-sandbox"
    Deployment  = "Terraform"
    Environment = "Sandbox"
  }
}

#### NAT GW ####
resource "aws_nat_gateway" "natgw-a" {
  allocation_id = aws_eip.eip-a.id
  subnet_id     = aws_subnet.subnet-sandbox_eu-west-1--LB1.id
  tags = {
    Name        = "NATGW-A"
    Deployment  = "Terraform"
    Environment = "Sandbox"
  }
}

resource "aws_nat_gateway" "natgw-b" {
  allocation_id = aws_eip.eip-b.id
  subnet_id     = aws_subnet.subnet-sandbox_eu-west-1--LB2.id
  tags = {
    Name        = "NATGW-B"
    Deployment  = "Terraform"
    Environment = "Sandbox"
  }
}

#### EIP ####
resource "aws_eip" "eip-a" {
  vpc = true
  tags = {
    Name        = "Elastic IP A"
    Deployment  = "Terraform"
    Environment = "Sandbox"
  }
}

resource "aws_eip" "eip-b" {
  vpc = true
  tags = {
    Name        = "Elastic IP B"
    Deployment  = "Terraform"
    Environment = "Sandbox"
  }
}