resource "aws_db_subnet_group" "db_subnet_group-sandbox" {
  subnet_ids = data.aws_subnet_ids.rds.ids
  tags = {
    Name        = "DB Subnet Group"
    Deployment  = "Terraform"
    Environment = "Sandbox"
  }
}

resource "aws_db_instance" "db_instance-sandbox" {
  allocated_storage      = 20
  storage_type           = "gp2"
  engine                 = "mysql"
  engine_version         = "8.0.15"
  instance_class         = "db.t2.micro"
  name                   = var.db_name
  username               = var.db_user
  password               = var.db_pass
  parameter_group_name   = "default.mysql8.0"
  db_subnet_group_name   = aws_db_subnet_group.db_subnet_group-sandbox.id
  multi_az               = true
  vpc_security_group_ids = [data.aws_security_group.rds.id]
  skip_final_snapshot    = true
  tags = {
    Name        = "db-instance-sandbox-byoi"
    Deployment  = "Terraform"
    Environment = "Sandbox"
  }
}