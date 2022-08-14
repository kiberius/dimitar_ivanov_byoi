#### PROVIDER AND BACKEND ####
provider "aws" {
  version = "~> 3.0"
  region  = "eu-west-1"
}

terraform {
  backend "s3" {
    bucket = "tfstate-bucket-dimitarivanov-sandbox"
    key    = "BYOI-dimitar_ivanov-tfstate/Sandbox/Services/Internet GW/terraform.tfstate"
    region = "eu-west-1"
  }
}

#### USED DATA ####
data "aws_vpc" "main" {
  tags = {
    Name = "VPC-dimitarivanov-sandbox"
  }
}

#### Internet GW ####
module "igw_dimitarivanov-sandbox_eu-west-1" {
  source = "../../../../Modules/Internet GW"
  Name   = "IGW-dimitarivanov-sandbox"
  vpc_id = data.aws_vpc.main.id
}