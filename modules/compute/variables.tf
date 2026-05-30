variable "vpc-id" {
  type = string
}
variable "web-subnet-id" {
  type = string
}
variable "app-subnet-id" {
  type = string
}
variable "db-subnet-id" {
  type = string
}


variable "web-network-interface-name" {
  type = string
  default = "web-network-interface"
}
variable "app-network-interface-name" {
  type = string
  default = "app-network-interface"
}
variable "db-network-interface-name" {
  type = string
  default = "db-network-interface"
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