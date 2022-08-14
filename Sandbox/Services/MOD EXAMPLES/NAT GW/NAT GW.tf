#### PROVIDER AND BACKEND ####
provider "aws" {
  version = "~> 3.0"
  region  = "eu-west-1"
}

terraform {
  backend "s3" {
    bucket = "tfstate-bucket-dimitarivanov-sandbox"
    key    = "BYOI-dimitar_ivanov-tfstate/Sandbox/Services/NAT GW/terraform.tfstate"
    region = "eu-west-1"
  }
}

#### USED DATA ####
data "aws_eip" "eip-a" {
  tags = {
    Name = "EIP-dimitarivanov-sandbox-A"
  }
}

data "aws_eip" "eip-b" {
  tags = {
    Name = "EIP-dimitarivanov-sandbox-B"
  }
}

data "aws_subnet" "subnet-a" {
  tags = {
    Name = "Application Instances Subnet A"
  }
}

data "aws_subnet" "subnet-b" {
  tags = {
    Name = "Application Instances Subnet B"
  }
}

#### NAT GW ####
module "natgw_dimitarivanov-sandbox_eu-west-1--1" {
  source        = "../../../../Modules/NAT GW"
  Name          = "NATGW-dimitarivanov-sandbox-A"
  allocation_id = data.aws_eip.eip-a.id
  subnet_id     = data.aws_subnet.subnet-a.id
}

module "natgw_dimitarivanov-sandbox_eu-west-1--2" {
  source        = "../../../../Modules/NAT GW"
  Name          = "NATGW-dimitarivanov-sandbox-B"
  allocation_id = data.aws_eip.eip-b.id
  subnet_id     = data.aws_subnet.subnet-b.id
}