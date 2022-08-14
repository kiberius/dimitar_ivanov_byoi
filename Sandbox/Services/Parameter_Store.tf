#resource "aws_ssm_parameter" "db_username" {
#  name  = "DB username"
#  type  = "String"
#  value = var.db_user
#}

#resource "aws_ssm_parameter" "db_password" {
#  name  = "DB password"
#  type  = "String"
#  value = var.db_pass
#}

#resource "aws_ssm_parameter" "wp_admin" {
#  name  = "WP username"
#  type  = "String"
#  value = var.wp_admin_user
#}

#resource "aws_ssm_parameter" "wp_pass" {
#  name  = "WP password"
#  type  = "String"
#  value = var.wp_admin_pass
#}

#resource "aws_ssm_parameter" "wp_admin_email" {
#  name  = "WP admin email"
#  type  = "String"
#  value = var.wp_admin_email
#}

#resource "aws_ssm_parameter" "dns_name" {
#  name  = "DNS name"
#  type  = "String"
#  value = var.dns_name
#}