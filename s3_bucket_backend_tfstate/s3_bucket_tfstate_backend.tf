#### PROVIDER ####
provider "aws" {
  version = "~> 3.0"
  region  = "eu-west-1"
}

terraform {
  backend "s3" {
    bucket = "tfstate-bucket-dimitarivanov-sandbox"
    key    = "BYOI-dimitar_ivanov-tfstate/Sandbox/s3_tfstate.tfstate"
    region = "eu-west-1"
  }
}

#### S3 BUCKET TFSTATE ####
resource "aws_s3_bucket" "s3_dimitarivanov-sandbox_eu-west-1_tfstate" {
  bucket = "tfstate-bucket-dimitarivanov-sandbox"
  acl    = "private"
  versioning {
    enabled = true
  }
  lifecycle {
    prevent_destroy = true
  }
  tags = {
    Name        = "tfstate-test-bucket-dimitarivanov-sandbox"
    Deployment  = "Terraform"
    Environment = "Sandbox"
  }
}