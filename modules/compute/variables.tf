variable "web-network-interface-name" {
  type = string
  default = "web_network_interface"
}
variable "app-network-interface-name" {
  type = string
  default = "app_network_interface"
}
variable "db-network-interface-name" {
  type = string
  default = "db_network_interface"
}

variable "web-instance-name" {
  type = string
  default = "web-server"
}

variable "app-instance-name" {
  type = string
  default = "app-server"
}

variable "db-instance-name" {
  type = string
  default = "db-server"
}