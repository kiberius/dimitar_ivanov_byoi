variable "load_balancer_arn" {
  type        = string
  description = "ID of the Load Balancer to which the listener belongs."
}

variable "port" {
  type        = string
  description = "Port in which the listener operates."
}

variable "protocol" {
  type        = string
  description = "Protocol on which the listener operates."
}

variable "target_group_arn" {
  type        = string
  description = "ARN of the Target Group to which the Listener forwards."
}