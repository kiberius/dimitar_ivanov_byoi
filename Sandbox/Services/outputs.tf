output "db_endpoint" {
  value = aws_db_instance.db_instance-sandbox.endpoint
}

output "lb_endpoint" {
  value = aws_lb.main.dns_name
}