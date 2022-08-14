resource "aws_s3_bucket" "main" {
  bucket = var.bucket
  acl    = var.acl
  versioning {
    enabled = var.versioning
  }

  tags = {
    Name        = var.Name
    IaC         = "Terraform"
    Environment = "Dev"
  }
}