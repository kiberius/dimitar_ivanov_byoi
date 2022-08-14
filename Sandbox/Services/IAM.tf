resource "aws_iam_role_policy" "app-policy" {
  name   = "app-policy"
  role   = aws_iam_role.app-role.id
  policy = file("./Services-Policies/Instace_Policy.json")
}

resource "aws_iam_role" "app-role" {
  name               = "app-role"
  assume_role_policy = file("./Services-Policies/Assume_App_Role_Policy.json")
  tags = {
    Name        = "app-role"
    Deployment  = "Terraform"
    Environment = "Sandbox"
  }
}

resource "aws_iam_instance_profile" "iam-instance-profile" {
  name = "iam-instance-profile"
  role = aws_iam_role.app-role.name
}