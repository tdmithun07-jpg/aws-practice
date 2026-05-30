variable "vpc-name" {
  default = "my-vpc"
}

variable "vpc-cidr" {
  default = "10.0.0.0/16"
}

variable "web-subnet" {
  default = "web-subnet"
}

variable "web-subnet-cidr" {
  default = "10.0.1.0/24"
}

variable "app-subnet" {
  default = "app-subnet"
} 

variable "app-subnet-cidr" {
  default = "10.0.2.0/24"
}

variable "db-subnet" {
  default = "db-subnet"
}

variable "db-subnet-cidr" {
  default = "10.0.3.0/24"
}
