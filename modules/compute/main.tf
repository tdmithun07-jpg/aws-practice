resource "aws_network_interface" "web-interface" {
  subnet_id   = var.web-subnet-id

  tags = {
    Name = var.web-network-interface-name
  }
}

# resource "aws_instance" "web-server" {
#   ami           = "ami-005e54dee72cc1d00" # us-west-2
#   instance_type = "t2.micro"
#   associate_public_ip_address = true # Forces a dynamic public IP

#   primary_network_interface {
#     network_interface_id = aws_network_interface.web-interface.id
#   }

#   tags = {
#     Name = var.web-instance-name
#   }
# }

resource "aws_network_interface" "app-interface" {
  subnet_id   = var.app-subnet-id

  tags = {
    Name = var.app-network-interface-name
  }
}

# resource "aws_instance" "app-server" {
#   ami           = "ami-005e54dee72cc1d00" # us-west-2
#   instance_type = "t2.micro"
#   associate_public_ip_address = true # Forces a dynamic public IP
#   primary_network_interface {
#     network_interface_id = aws_network_interface.app-interface.id
#   }

#  tags = {
#     Name = var.app-instance-name
#   }
# }

resource "aws_network_interface" "db-interface" {
  subnet_id   = var.db-subnet-id
  private_ips = ["172.16.10.100"]

  tags = {
    Name = var.db-network-interface-name
  }
}

# resource "aws_instance" "db-server" {
#   ami           = "ami-005e54dee72cc1d00" # us-west-2
#   instance_type = "t2.micro"
#   associate_public_ip_address = true # Forces a dynamic public IP
#   primary_network_interface {
#     network_interface_id = aws_network_interface.db-interface.id
#   }

#     tags = {
#         Name = var.db-instance-name
#     }
# }