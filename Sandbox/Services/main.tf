#### PROVIDER AND BACKEND ####
provider "aws" {
  version = "~> 3.0"
  region  = "eu-west-1"
}

terraform {
  backend "s3" {
    bucket = "tfstate-bucket-dimitarivanov-sandbox"
    key    = "BYOI-dimitar_ivanov-tfstate/Sandbox/services.tfstate"
    region = "eu-west-1"
  }
}

#### DATA USED ####
data "aws_vpc" "main" {
  tags = {
    Name = "VPC-sandbox"
  }
}

data "aws_subnet_ids" "lb" {
  vpc_id = data.aws_vpc.main.id
  tags = {
    Name = "Load Balancer*"
  }
}

data "aws_security_group" "lb" {
  tags = {
    Name = "Load Balancer SG"
  }
}

data "aws_security_group" "rds" {
  tags = {
    Name = "RDS SG"
  }
}

data "aws_subnet_ids" "rds" {
  tags = {
    Name = "RDS*"
  }
  vpc_id = data.aws_vpc.main.id
}

data "aws_security_group" "app" {
  tags = {
    Name = "Application SG"
  }
}

data "aws_subnet_ids" "app" {
  tags = {
    Name = "Application*"
  }
  vpc_id = data.aws_vpc.main.id
}

data "aws_ami" "AmazonAMI" {
  most_recent = true
  filter {
    name   = "owner-alias"
    values = ["amazon"]
  }
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }
  owners = ["amazon"]
}

data "aws_security_groups" "app" {
  tags = {
    Name = "Application*"
  }
}

data "aws_subnet" "bastion-subnet" {
  tags = {
    Name = "Load Balancer Subnet A"
  }
}

data "aws_security_group" "bastion" {
  tags = {
    Name = "Bastion SG"
  }
}

data "aws_iam_role" "AdminAccess" {
  name = "AdminAccess"
}