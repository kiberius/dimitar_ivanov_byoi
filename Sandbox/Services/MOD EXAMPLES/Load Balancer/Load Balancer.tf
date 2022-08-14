#### PROVIDER AND BACKEND ####
provider "aws" {
  version = "~> 3.0"
  region  = "eu-west-1"
}

terraform {
  backend "s3" {
    bucket = "tfstate-bucket-dimitarivanov-sandbox"
    key    = "BYOI-dimitar_ivanov-tfstate/Sandbox/Services/Load Balancer/terraform.tfstate"
    region = "eu-west-1"
  }
}

#### USED DATA ####
data "aws_vpc" "main" {
  tags = {
    Name = "VPC-dimitarivanov-sandbox"
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

data "aws_security_group" "main" {
  tags = {
    Name = "Load Balancer SG"
  }
}

data "aws_subnet_ids" "main" {
  vpc_id = data.aws_vpc.main.id
  tags = {
    Name = "Load Balancer Subnet*"
  }
}

#### LOAD BALANCER ####
module "load_balancer_dimitarivanov-sandbox_eu-west-1" {
  source          = "../../../../Modules/Load Balancer"
  Name            = "Load-Balancer-sandbox"
  security_groups = [data.aws_security_group.main.id]
  subnets         = data.aws_subnet_ids.main.ids
}
