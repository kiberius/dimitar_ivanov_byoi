variable "Name" {
  type        = string
  description = "Name of the Security Group."
}

variable "description" {
  type        = string
  description = "Description of the Security Group."
}

variable "vpc_id" {
  type        = string
  description = "ID of the VPC to which the Security Group belongs."
}