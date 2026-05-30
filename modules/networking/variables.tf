variable "vpc-name" {
  type = string
  default = "my-vpc"
}

variable "vpc-cidr" {
  type = string
  default = "10.0.0.0/16"
}

variable "web-subnet" {
  type = string
  default = "web-subnet"
}

variable "web-subnet-cidr" {
  type = string
  default = "10.0.1.0/24"
}

variable "app-subnet" {
  type = string
  default = "app-subnet"
} 

variable "app-subnet-cidr" {
  type = string
  default = "10.0.2.0/24"
}

variable "db-subnet" {
  type = string
  default = "db-subnet"
}

variable "db-subnet-cidr" {
  type = string
  default = "10.0.3.0/24"
}
