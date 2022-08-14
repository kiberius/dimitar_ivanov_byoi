variable "allocation_id" {
  type        = string
  description = "Allocation ID of the elastic IP which is attached to the NAT GW."
}

variable "subnet_id" {
  type        = string
  description = "Subnet ID of the subnet which is attached to the NAT GW."
}

variable "Name" {
  type        = string
  description = "Name of the NAT GW."
}