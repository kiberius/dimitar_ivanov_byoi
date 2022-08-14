#### PROVIDER AND BACKEND ####
provider "aws" {
  version = "~> 3.0"
  region  = "eu-west-1"
}

terraform {
  backend "s3" {
    bucket = "tfstate-bucket-dimitarivanov-sandbox"
    key    = "BYOI-dimitar_ivanov-tfstate/Sandbox/Services/Route Table Associations/terraform.tfstate"
    region = "eu-west-1"
  }
}

#### USED DATA ####
data "aws_route_table" "first" {
  tags = {
    Name = "Public Route Table for Load Balancer-dimitarivanov-sandbox"
  }
}

data "aws_route_table" "second" {
  tags = {
    Name = "Private Route Table for Application Instances A-dimitarivanov-sandbox"
  }
}

data "aws_route_table" "third" {
  tags = {
    Name = "Private Route Table for Application Instances B-dimitarivanov-sandbox"
  }
}

data "aws_subnet" "first" {
  tags = {
    Name = "Load Balancer Subnet A"
  }
}

data "aws_subnet" "second" {
  tags = {
    Name = "Load Balancer Subnet B"
  }
}

data "aws_subnet" "third" {
  tags = {
    Name = "Application Instances Subnet A"
  }
}

data "aws_subnet" "fourth" {
  tags = {
    Name = "Application Instances Subnet B"
  }
}

#### ROUTE TABLE ASSOCIATIONS ####
module "publicroutetableassociation_dimitarivanov-sandbox_eu-west-1--1" {
  source         = "../../../../Modules/Route Table Associations"
  subnet_id      = data.aws_subnet.first.id
  route_table_id = data.aws_route_table.first.id
}

module "publicroutetableassociation_dimitarivanov-sandbox_eu-west-1--2" {
  source         = "../../../../Modules/Route Table Associations"
  subnet_id      = data.aws_subnet.second.id
  route_table_id = data.aws_route_table.first.id
}

module "privateroutetableassociation_dimitarivanov-sandbox_eu-west-1--1" {
  source         = "../../../../Modules/Route Table Associations"
  subnet_id      = data.aws_subnet.third.id
  route_table_id = data.aws_route_table.second.id
}

module "privateroutetableassociation_dimitarivanov-sandbox_eu-west-1--2" {
  source         = "../../../../Modules/Route Table Associations"
  subnet_id      = data.aws_subnet.fourth.id
  route_table_id = data.aws_route_table.third.id
}