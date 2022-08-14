variable "type" {
  type        = string
  description = "ingress OR egress"
}

variable "from_port" {
  type        = number
  description = "Bottom range port"
}

variable "to_port" {
  type        = number
  description = "Top range port."
}

variable "protocol" {
  type        = string
  description = "Specify the type of network traffic."
}

variable "cidr_blocks" {
  type        = list(string)
  description = "Specify the IPv4 CIDR block. Does NOT work in conjunction with [source_security_group_id]."
  default     = null
}

variable "security_group_id" {
  type        = string
  description = "Specify the Security Group ID to which the rule belongs."
}

