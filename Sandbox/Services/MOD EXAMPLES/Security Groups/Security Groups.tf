#### PROVIDER AND BACKEND ####
provider "aws" {
  version = "~> 3.0"
  region  = "eu-west-1"
}

terraform {
  backend "s3" {
    bucket = "tfstate-bucket-dimitarivanov-sandbox"
    key    = "BYOI-dimitar_ivanov-tfstate/Sandbox/Services/Security Groups/terraform.tfstate"
    region = "eu-west-1"
  }
}

#### USED DATA ####
data "aws_vpc" "main" {
  tags = {
    Name = "VPC-dimitarivanov-sandbox"
  }
}

#### SECURITY GROUPS ####
module "security_group_dimitarivanov-sandbox_eu-west-1--1" {
  source      = "../../../../Modules/Security Group"
  Name        = "Load Balancer SG"
  description = "Load Balancer Security Group"
  vpc_id      = data.aws_vpc.main.id
}

module "security_group_dimitarivanov-sandbox_eu-west-1--2" {
  source      = "../../../../Modules/Security Group"
  Name        = "Application Instances SG"
  description = "Application Instances Security Group"
  vpc_id      = data.aws_vpc.main.id
}

module "security_group_dimitarivanov-sandbox_eu-west-1--3" {
  source      = "../../../../Modules/Security Group"
  Name        = "RDS SG"
  description = "RDS Security Group"
  vpc_id      = data.aws_vpc.main.id
}