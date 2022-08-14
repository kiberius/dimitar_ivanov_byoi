#### PROVIDER AND BACKEND ####
provider "aws" {
  version = "~> 3.0"
  region  = "eu-west-1"
}

terraform {
  backend "s3" {
    bucket = "tfstate-bucket-dimitarivanov-sandbox"
    key    = "BYOI-dimitar_ivanov-tfstate/Sandbox/Services/Load Balancer Attachment/terraform.tfstate"
    region = "eu-west-1"
  }
}

#### USED DATA ####
data "aws_lb_target_group" "main" {
  tags = {
    Name = "Target-Group-sandbox"
  }
}

data "aws_instances" "main" {
  filter {
    name = "tag:Name"
    values = ["Server Instances"]
  }
}

#### ATTACHMENT ####
module "load_balancer_target_group_attachment_dimitarivanov-sandbox_eu-west-1" {
  source           = "../../../../Modules/Load Balancer Attachment"
  target_group_arn = data.aws_lb_target_group.main.arn
  target_id        = data.aws_instances.main.ids
}

#### NOT IMPLEMENTED ####