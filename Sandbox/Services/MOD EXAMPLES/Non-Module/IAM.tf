resource "aws_iam_role_policy" "iam_role_policy-dimitarivanov-sandbox_eu-west-1" {
  name   = "IAM_Role_Policy-dimitarivanov-sandbox"
  role   = aws_iam_role.iam_role-dimitarivanov-sandbox_eu-west-1.id
  policy = file("../../Policies/Instace_Policy.json")
}

resource "aws_iam_role" "iam_role-dimitarivanov-sandbox_eu-west-1" {
  name               = "IAM_Role-dimitarivanov-sandbox"
  assume_role_policy = file("../../../Policies/Assume_App_Role_Policy.json")
  tags = {
    Name        = "IAM_Role-dimitarivanov-sandbox"
    IaC         = "Terraform"
    Environment = "Dev"
  }
}

resource "aws_iam_instance_profile" "iam_instance_profile-dimitarivanov-sandbox_eu-west-1" {
  name = "IAM_Instance_Profile-dimitarivanov-sandbox"
  role = aws_iam_role.iam_role-dimitarivanov-sandbox_eu-west-1.name
}