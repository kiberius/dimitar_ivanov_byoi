variable "name" {
  type = string
  description = "Name of the Target Group."
}

variable "port" {
  type = number
  description = "Port on which the targets receive traffic."
}

variable "protocol" {
  type = string
  description = "GENEVE or HTTP or HTTPS or TCP or TCP_UDP or TLS or UD"
}

variable "vpc_id" {
  type = string
  description = "Specifies the ID of the VPC in which the Target Group is created."
}