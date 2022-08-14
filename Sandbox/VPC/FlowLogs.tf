resource "aws_flow_log" "flowlog-sandbox" {
  iam_role_arn    = aws_iam_role.vpc-role.arn
  log_destination = aws_cloudwatch_log_group.loggroup-sandbox.arn
  traffic_type    = "ALL"
  vpc_id          = aws_vpc.main.id
  tags = {
    Name        = "FlowLog-sandbox"
    Deployment  = "Terraform"
    Environment = "Sandbox"
  }
}

resource "aws_cloudwatch_log_group" "loggroup-sandbox" {
  name = "FlowLogs-sandbox"
  tags = {
    Name        = "LogGroup-Sandbox"
    Deployment  = "Terraform"
    Environment = "Sandbox"
  }
}