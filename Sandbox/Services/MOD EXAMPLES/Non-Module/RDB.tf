#### DATA USED ####
data "aws_security_group" "rdb_security_group" {
  tags = {
    Name = "RDS SG"
  }
}

data "aws_subnet_ids" "rds" {
  tags = {
    Name = "RDS*"
  }
  vpc_id = data.aws_vpc.main.id
}

data "aws_ssm_parameter" "DBuser" {
  name = "DB_User"
}

data "aws_ssm_parameter" "DBpass" {
  name = "DB_Pass"
}

#### DB ####
resource "aws_db_subnet_group" "db_subnet_group-dimitarivanov-sandbox_eu-west-1" {
  subnet_ids = data.aws_subnet_ids.rds.ids
  tags = {
    Name        = "DB Subnet Group"
    IaC         = "Terraform"
    Environment = "Dev"
  }
}

resource "aws_db_instance" "db_instance-dimitarivanov-sandbox_eu-west-1" {
  identifier             = "db-instance-dimitarivanov-sandbox"
  allocated_storage      = 20
  storage_type           = "gp2"
  engine                 = "mysql"
  engine_version         = "5.7"
  instance_class         = "db.t3.micro"
  name                   = "DB_sandbox"
  username               = data.aws_ssm_parameter.DBuser
  password               = data.aws_ssm_parameter.DBpass
  parameter_group_name   = "default.mysql5.7"
  db_subnet_group_name   = aws_db_subnet_group.db_subnet_group-dimitarivanov-sandbox_eu-west-1.id
  multi_az               = true
  vpc_security_group_ids = [data.aws_security_group.rdb_security_group.id]
  skip_final_snapshot    = "true"
  tags = {
    Name = "db-instance-sandbox"
  }
}