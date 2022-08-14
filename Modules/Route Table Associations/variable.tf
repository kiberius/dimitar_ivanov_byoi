variable "subnet_id" {
  type    = string
  default = "ID of the subnet which is attached to the route table."
}

variable "route_table_id" {
  type    = string
  default = "ID of the route table which is attached to the subnet."
}