#### PROVIDER AND BACKEND ####
provider "aws" {
  version = "~> 3.0"
  region  = "eu-west-1"
}

terraform {
  backend "s3" {
    bucket = "tfstate-bucket-dimitarivanov-sandbox"
    key    = "BYOI-dimitar_ivanov-tfstate/Sandbox/Services/Route Tables/terraform.tfstate"
    region = "eu-west-1"
  }
}

#### USED DATA ####
data "aws_internet_gateway" "main" {
  tags = {
    Name = "IGW-dimitarivanov-sandbox"
  }
}

data "aws_nat_gateway" "first" {
  tags = {
    Name = "NATGW-dimitarivanov-sandbox-A"
  }
}

data "aws_nat_gateway" "second" {
  tags = {
    Name = "NATGW-dimitarivanov-sandbox-B"
  }
}

data "aws_vpc" "main" {
  tags = {
    Name = "VPC-dimitarivanov-sandbox"
  }
}

#### ROUTE TABLES ####
module "routetable_dimitarivanov-sandbox_eu-west-1--1" {
  source     = "../../../../Modules/Route Table"
  Name       = "Public Route Table for Load Balancer-dimitarivanov-sandbox"
  cidr_block = "0.0.0.0/0"
  gateway_id = data.aws_internet_gateway.main.id
  vpc_id     = data.aws_vpc.main.id
}

module "routetable_dimitarivanov-sandbox_eu-west-1--2" {
  source         = "../../../../Modules/Route Table"
  Name           = "Private Route Table for Application Instances A-dimitarivanov-sandbox"
  cidr_block     = "0.0.0.0/0"
  nat_gateway_id = data.aws_nat_gateway.first.id
  vpc_id         = data.aws_vpc.main.id
}

module "routetable_dimitarivanov-sandbox_eu-west-1--3" {
  source         = "../../../../Modules/Route Table"
  Name           = "Private Route Table for Application Instances B-dimitarivanov-sandbox"
  cidr_block     = "0.0.0.0/0"
  nat_gateway_id = data.aws_nat_gateway.second.id
  vpc_id         = data.aws_vpc.main.id
}