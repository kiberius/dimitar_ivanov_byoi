#### PROVIDER AND BACKEND ####""
provider "aws" {
  version = "~> 3.0"
  region  = "eu-west-1"
}

terraform {
  backend "s3" {
    bucket = "tfstate-bucket-dimitarivanov-sandbox"
    key    = "BYOI-dimitar_ivanov-tfstate/Sandbox/Services/Load Balancer Listener/terraform.tfstate"
    region = "eu-west-1"
  }
}

#### USED DATA ####
data "aws_lb" "main" {
  tags = {
    Name = "Load-Balancer-sandbox"
  }
}

data "aws_lb_target_group" "main" {
  tags = {
    Name = "Target-Group-sandbox"
  }
}

#### LISTENER ####
module "load_balancer_listener_dimitarivanov-sandbox_eu-west-1" {
  source            = "../../../../Modules/Load Balancer Listener"
  load_balancer_arn = data.aws_lb.main.arn
  port              = 80
  protocol          = "HTTP"
  target_group_arn  = data.aws_lb_target_group.main.arn
}