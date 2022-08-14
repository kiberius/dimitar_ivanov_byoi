variable "vpc_id" {
  type        = string
  description = "VPC ID of the VPC to which the route table belongs."
}

variable "cidr_block" {
  type        = string
  description = "Destination IP range."
}

variable "gateway_id" {
  type        = string
  default     = ""
  description = "Internet GW ID of the route target."
}

variable "nat_gateway_id" {
  type        = string
  default     = ""
  description = "NAT GW ID of the route target."
}

variable "Name" {
  type        = string
  description = "Name of the route table."
}