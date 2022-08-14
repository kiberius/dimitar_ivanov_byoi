#### PROVIDER AND BACKEND ####
provider "aws" {
  version = "~> 3.0"
  region  = "eu-west-1"
}

terraform {
  backend "s3" {
    bucket = "tfstate-bucket-dimitarivanov-sandbox"
    key    = "BYOI-dimitar_ivanov-tfstate/Sandbox/Services/Security Group Rules/terraform.tfstate"
    region = "eu-west-1"
  }
}

#### USED DATA ####
data "aws_security_group" "load_balancer" {
  tags = {
    Name = "Load Balancer SG"
  }
}

data "aws_security_group" "application_instances" {
  tags = {
    Name = "Application Instances SG"
  }
}

data "aws_security_group" "rds" {
  tags = {
    Name = "RDS SG"
  }
}

#### SECURITY GROUP RULES ####
module "security_group_rule_dimitarivanov-sandbox_eu-west-1--1" {
  source            = "../../../../Modules/Security Group Rule"
  cidr_blocks       = ["0.0.0.0/0"]
  from_port         = 80
  protocol          = "tcp"
  security_group_id = data.aws_security_group.load_balancer.id
  to_port           = 80
  type              = "ingress"
}

module "security_group_rule_dimitarivanov-sandbox_eu-west-1--2" {
  source            = "../../../../Modules/Security Group Rule"
  cidr_blocks       = ["0.0.0.0/0"]
  from_port         = 443
  protocol          = "tcp"
  security_group_id = data.aws_security_group.load_balancer.id
  to_port           = 443
  type              = "ingress"
}

module "security_group_rule_dimitarivanov-sandbox_eu-west-1--3" {
  source            = "../../../../Modules/Security Group Rule"
  from_port         = 0
  protocol          = -1
  security_group_id = data.aws_security_group.load_balancer.id
  to_port           = 0
  type              = "egress"
  cidr_blocks       = ["0.0.0.0/0"]
}

module "security_group_rule_dimitarivanov-sandbox_eu-west-1--4" {
  source            = "../../../../Modules/Security Group Rule"
  from_port         = 80
  protocol          = "tcp"
  security_group_id = data.aws_security_group.application_instances.id
  to_port           = 80
  type              = "ingress"
  cidr_blocks       = ["0.0.0.0/0"]
}

module "security_group_rule_dimitarivanov-sandbox_eu-west-1--5" {
  source            = "../../../../Modules/Security Group Rule"
  from_port         = 443
  protocol          = "tcp"
  security_group_id = data.aws_security_group.application_instances.id
  to_port           = 443
  type              = "ingress"
  cidr_blocks       = ["0.0.0.0/0"]
}

module "security_group_rule_dimitarivanov-sandbox_eu-west-1--6" {
  source            = "../../../../Modules/Security Group Rule"
  from_port         = 22
  protocol          = "tcp"
  security_group_id = data.aws_security_group.application_instances.id
  to_port           = 22
  type              = "ingress"
  cidr_blocks       = ["10.0.0.0/16"]
}

module "security_group_rule_dimitarivanov-sandbox_eu-west-1--7" {
  source            = "../../../../Modules/Security Group Rule"
  from_port         = 0
  protocol          = -1
  security_group_id = data.aws_security_group.application_instances.id
  to_port           = 0
  type              = "egress"
  cidr_blocks       = ["0.0.0.0/0"]
}

module "security_group_rule_dimitarivanov-sandbox_eu-west-1--8" {
  source            = "../../../../Modules/Security Group Rule"
  from_port         = 3306
  protocol          = "tcp"
  security_group_id = data.aws_security_group.rds.id
  to_port           = 3306
  type              = "ingress"
  cidr_blocks       = ["10.0.0.0/16"]
}

module "security_group_rule_dimitarivanov-sandbox_eu-west-1--9" {
  source            = "../../../../Modules/Security Group Rule"
  from_port         = 0
  protocol          = -1
  security_group_id = data.aws_security_group.rds.id
  to_port           = 0
  type              = "egress"
  cidr_blocks       = ["0.0.0.0/0"]
}

module "security_group_rule_dimitarivanov-sandbox_eu-west-1--10" {
  source            = "../../../../Modules/Security Group Rule"
  cidr_blocks       = ["0.0.0.0/0"]
  from_port         = 22
  protocol          = "tcp"
  security_group_id = data.aws_security_group.load_balancer.id
  to_port           = 22
  type              = "ingress"
}