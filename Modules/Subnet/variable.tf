variable "vpc_id" {
  type = string
  description = "The VPC ID of the subnet."
  }

variable "cidr_block" {
  type = string
  description = "The CIDR block of the subnet."
}

variable "Name" {
  type = string
  description = "The Name of the subnet."
}

variable "availability_zone" {
  type = string
  description = "The AZ in which the subnet is located."
}