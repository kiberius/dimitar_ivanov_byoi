#### PROVIDER AND BACKEND ####
provider "aws" {
  version = "~> 3.0"
  region  = "eu-west-1"
}

terraform {
  backend "s3" {
    bucket = "tfstate-bucket-dimitarivanov-sandbox"
    key    = "BYOI-dimitar_ivanov-tfstate/Sandbox/Services/Elastic IP/terraform.tfstate"
    region = "eu-west-1"
  }
}

#### Elastic IP ####
module "eip_dimitarivanov-sandbox_eu-west-1--1" {
  source = "../../../../Modules/Elastic IP"
  Name = "EIP-dimitarivanov-sandbox-A"
}

module "eip_dimitarivanov-sandbox_eu-west-1--2" {
  source = "../../../../Modules/Elastic IP"
  Name = "EIP-dimitarivanov-sandbox-B"
}