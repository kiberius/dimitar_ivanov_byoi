resource "aws_subnet" "subnet-sandbox_eu-west-1--LB1" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.1.0/27"
  availability_zone = "eu-west-1a"
  #  map_public_ip_on_launch = true
  tags = {
    Name        = "Load Balancer Subnet A"
    Deployment  = "Terraform"
    Environment = "Sandbox"
  }
}

resource "aws_subnet" "subnet-sandbox_eu-west-1--LB2" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.2.0/27"
  availability_zone = "eu-west-1b"
  #  map_public_ip_on_launch = true
  tags = {
    Name        = "Load Balancer Subnet B"
    Deployment  = "Terraform"
    Environment = "Sandbox"
  }
}

resource "aws_subnet" "subnet-sandbox_eu-west-1--APP1" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.3.0/27"
  availability_zone = "eu-west-1a"
  #  map_public_ip_on_launch = false
  tags = {
    Name        = "Application Instances Subnet A"
    Deployment  = "Terraform"
    Environment = "Sandbox"
  }
}

resource "aws_subnet" "subnet-sandbox_eu-west-1--APP2" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.4.0/27"
  availability_zone = "eu-west-1b"
  #  map_public_ip_on_launch = false
  tags = {
    Name        = "Application Instances Subnet B"
    Deployment  = "Terraform"
    Environment = "Sandbox"
  }
}

resource "aws_subnet" "subnet-sandbox_eu-west-1--RDS1" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.5.0/27"
  availability_zone = "eu-west-1a"
  #  map_public_ip_on_launch = false
  tags = {
    Name        = "RDS Subnet A"
    Deployment  = "Terraform"
    Environment = "Sandbox"
  }
}

resource "aws_subnet" "subnet-sandbox_eu-west-1--RDS2" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.6.0/27"
  availability_zone = "eu-west-1b"
  #  map_public_ip_on_launch = false
  tags = {
    Name        = "RDS Subnet B"
    Deployment  = "Terraform"
    Environment = "Sandbox"
  }
}