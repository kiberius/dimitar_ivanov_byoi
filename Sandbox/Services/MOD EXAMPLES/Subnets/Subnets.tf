#### PROVIDER AND BACKEND ####
provider "aws" {
  version = "~> 3.0"
  region  = "eu-west-1"
}

terraform {
  backend "s3" {
    bucket = "tfstate-bucket-dimitarivanov-sandbox"
    key    = "BYOI-dimitar_ivanov-tfstate/Sandbox/Services/Subnets/terraform.tfstate"
    region = "eu-west-1"
  }
}

#### USED DATA ####
data "aws_vpc" "main" {
  tags = {
    Name = "VPC-dimitarivanov-sandbox"
  }
}

#### SUBNETS ####
module "subnet_dimitarivanov-sandbox_eu-west-1--1" {
  source            = "../../../../Modules/Subnet"
  Name              = "Load Balancer Subnet A"
  availability_zone = "eu-west-1a"
  cidr_block        = "10.0.1.0/24"
  vpc_id            = data.aws_vpc.main.id

}

module "subnet_dimitarivanov-sandbox_eu-west-1--2" {
  source            = "../../../../Modules/Subnet"
  Name              = "Load Balancer Subnet B"
  availability_zone = "eu-west-1b"
  cidr_block        = "10.0.2.0/24"
  vpc_id            = data.aws_vpc.main.id
}

module "subnet_dimitarivanov-sandbox_eu-west-1--3" {
  source            = "../../../../Modules/Subnet"
  Name              = "Application Instances Subnet A"
  availability_zone = "eu-west-1a"
  cidr_block        = "10.0.3.0/24"
  vpc_id            = data.aws_vpc.main.id
}

module "subnet_dimitarivanov-sandbox_eu-west-1--4" {
  source            = "../../../../Modules/Subnet"
  Name              = "Application Instances Subnet B"
  availability_zone = "eu-west-1b"
  cidr_block        = "10.0.4.0/24"
  vpc_id            = data.aws_vpc.main.id
}

module "subnet_dimitarivanov-sandbox_eu-west-1--5" {
  source            = "../../../../Modules/Subnet"
  Name              = "RDS Subnet A"
  availability_zone = "eu-west-1a"
  cidr_block        = "10.0.5.0/24"
  vpc_id            = data.aws_vpc.main.id
}

module "subnet_dimitarivanov-sandbox_eu-west-1--6" {
  source            = "../../../../Modules/Subnet"
  Name              = "RDS Subnet B"
  availability_zone = "eu-west-1b"
  cidr_block        = "10.0.6.0/24"
  vpc_id            = data.aws_vpc.main.id
}