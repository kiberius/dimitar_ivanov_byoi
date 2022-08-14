output "vpc" {
  value = aws_vpc.main.id
}

output "lb-sg" {
  value = aws_security_group.LB.id
}

output "app-sg" {
  value = aws_security_group.APP.id
}

output "db-sg" {
  value = aws_security_group.RDS.id
}

output "sub-lb-1" {
  value = aws_subnet.subnet-sandbox_eu-west-1--LB1.id
}

output "sub-lb-2" {
  value = aws_subnet.subnet-sandbox_eu-west-1--LB2.id
}

output "sub-app-1" {
  value = aws_subnet.subnet-sandbox_eu-west-1--APP1.id
}

output "sub-app-2" {
  value = aws_subnet.subnet-sandbox_eu-west-1--APP2.id
}

output "sub-rds-1" {
  value = aws_subnet.subnet-sandbox_eu-west-1--RDS1.id
}

output "sub-rds-2" {
  value = aws_subnet.subnet-sandbox_eu-west-1--RDS2.id
}