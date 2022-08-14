resource "aws_security_group" "LB" {
  name        = "Load Balancer SG"
  description = "Load Balancer Security Group"
  vpc_id      = aws_vpc.main.id
  ingress {
    description = "HTTP to LB"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "HTTPS to LB"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name        = "Load Balancer SG"
    Deployment  = "Terraform"
    Environment = "Sandbox"
  }
}

resource "aws_security_group" "APP" {
  name        = "Application SG"
  description = "Application Security Group"
  vpc_id      = aws_vpc.main.id
  ingress {
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [aws_security_group.bastion.id]
  }
  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.LB.id]
  }
  ingress {
    from_port       = 443
    to_port         = 443
    protocol        = "tcp"
    security_groups = [aws_security_group.LB.id]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name        = "Application SG"
    Deployment  = "Terraform"
    Environment = "Sandbox"
  }
}

resource "aws_security_group" "RDS" {
  name        = "RDS SG"
  description = "RDS Security Group"
  vpc_id      = aws_vpc.main.id
  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.APP.id]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name        = "RDS SG"
    Deployment  = "Terraform"
    Environment = "Sandbox"
  }
}

resource "aws_security_group" "bastion" {
  name        = "Bastion SG"
  description = "Bastion Security Group"
  vpc_id      = aws_vpc.main.id
  ingress {
    description = "SSH to Bastion"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "HTTP to Bastion for testing scripts"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name        = "Bastion SG"
    Deployment  = "Terraform"
    Environment = "Sandbox"
  }
}