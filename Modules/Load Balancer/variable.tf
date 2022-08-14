variable "Name" {
  type        = string
  description = "Name of the Load Balancer"
}

variable "security_groups" {
  type        = set(string)
  description = "IDs of the Security Groups to which the Load Balancer belongs."
}

variable "subnets" {
  type        = set(string)
  description = "IDs of the Subnets to which the Load Balancer belongs."
}