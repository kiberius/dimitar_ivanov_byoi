resource "aws_iam_role" "vpc-role" {
  name               = "vpc-role"
  assume_role_policy = file("./policies/vpc_iam_role_policy.json")
  tags = {
    Deployment  = "Terraform"
    Environment = "Sandbox"
    Name        = "VPC-Role-sandbox"
  }
}
resource "aws_iam_role_policy" "vpc-role-policy" {
  role   = aws_iam_role.vpc-role.id
  policy = file("./policies/vpc_iam_assume_role_policy.json")
}