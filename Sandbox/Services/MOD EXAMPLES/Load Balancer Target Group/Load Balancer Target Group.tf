#### PROVIDER AND BACKEND ####
provider "aws" {
  version = "~> 3.0"
  region  = "eu-west-1"
}

terraform {
  backend "s3" {
    bucket = "tfstate-bucket-dimitarivanov-sandbox"
    key    = "BYOI-dimitar_ivanov-tfstate/Sandbox/Services/Load Balancer Target Group/terraform.tfstate"
    region = "eu-west-1"
  }
}

#### USED DATA ####
data "aws_vpc" "main" {
  tags = {
    Name = "VPC-dimitarivanov-sandbox"
  }
}

#### TARGET GROUP ####
module "load_balancer_target_group_dimitarivanov-sandbox_eu-west-1" {
  source   = "../../../../Modules/Load Balancer Target Group"
  name     = "Target-Group-sandbox"
  port     = 80
  protocol = "HTTP"
  vpc_id   = data.aws_vpc.main.id
}
