#### ROUTE TABLES ####
resource "aws_route_table" "LB" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }

  tags = {
    Name        = "Load Balancer Route Table-sandbox"
    Deployment  = "Terraform"
    Environment = "Sandbox"
  }
}

resource "aws_route_table" "AppA" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.natgw-a.id
  }
  tags = {
    Name        = "Application Route Table A-sandbox"
    Deployment  = "Terraform"
    Environment = "Sandbox"
  }
}

resource "aws_route_table" "AppB" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.natgw-b.id
  }
  tags = {
    Name        = "Application Route Table B-sandbox"
    Deployment  = "Terraform"
    Environment = "Sandbox"
  }
}

resource "aws_route_table" "RDS" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "RDS Table B-sandbox"
    Deployment = "Terraform"
    Environment = "Sandbox"
  }
}

#### ASSOCIATIONS ####
resource "aws_route_table_association" "first" {
  subnet_id      = aws_subnet.subnet-sandbox_eu-west-1--LB1.id
  route_table_id = aws_route_table.LB.id
}

resource "aws_route_table_association" "second" {
  subnet_id      = aws_subnet.subnet-sandbox_eu-west-1--LB2.id
  route_table_id = aws_route_table.LB.id
}

resource "aws_route_table_association" "third" {
  subnet_id      = aws_subnet.subnet-sandbox_eu-west-1--APP1.id
  route_table_id = aws_route_table.AppA.id
}

resource "aws_route_table_association" "fourth" {
  subnet_id      = aws_subnet.subnet-sandbox_eu-west-1--APP2.id
  route_table_id = aws_route_table.AppB.id
}

resource "aws_route_table_association" "fifth" {
  subnet_id      = aws_subnet.subnet-sandbox_eu-west-1--RDS1.id
  route_table_id = aws_route_table.RDS.id
}

resource "aws_route_table_association" "sixth" {
  subnet_id      = aws_subnet.subnet-sandbox_eu-west-1--RDS2.id
  route_table_id = aws_route_table.RDS.id
}
