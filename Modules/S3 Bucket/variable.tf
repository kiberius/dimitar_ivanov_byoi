variable "bucket" {
  type = string
  description = "Unique name of the S3 bucket."
}

variable "acl" {
  default = "private"
}

variable "versioning" {
  default = True
  description = "S3 bucket versioning."
}

variable "Name" {
  type = string
  description = "Non-unique name of the S3 bucket."
}