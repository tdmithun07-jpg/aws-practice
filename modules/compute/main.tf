# 1. Look up the secret metadata by its name
data "aws_secretsmanager_secret" "ssh_key_meta" {
  name = "sshkey0106"
}
# 2. Fetch the actual content payload using the secret's ID
data "aws_secretsmanager_secret_version" "ssh_public_key" {
  secret_id = data.aws_secretsmanager_secret.ssh_key_meta.id
}

# Register the public key string as an AWS Key Pair
resource "aws_key_pair" "web_key" {
  key_name   = "web-admin-key"
  public_key = data.aws_secretsmanager_secret_version.ssh_public_key.secret_string
}

###############################################################

resource "aws_network_interface" "web-interface" {
  subnet_id   = var.web-subnet-id

  tags = {
    Name = var.web-network-interface-name
  }
}

resource "aws_instance" "web-server" {
  ami           = "ami-091138d0f0d41ff90" # us-west-2
  instance_type = "t2.micro"
  associate_public_ip_address = true # Forces a dynamic public IP
    key_name      = aws_key_pair.web_key.key_name

  primary_network_interface {
    network_interface_id = aws_network_interface.web-interface.id
  }

  tags = {
    Name = var.web-instance-name
  }
}

resource "aws_network_interface" "app-interface" {
  subnet_id   = var.app-subnet-id

  tags = {
    Name = var.app-network-interface-name
  }
}

# resource "aws_instance" "app-server" {
#   ami           = "ami-091138d0f0d41ff90" # us-west-2
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

  tags = {
    Name = var.db-network-interface-name
  }
}

# resource "aws_instance" "db-server" {
#   ami           = "ami-091138d0f0d41ff90" # us-west-2
#   instance_type = "t2.micro"
#   associate_public_ip_address = true # Forces a dynamic public IP
#   primary_network_interface {
#     network_interface_id = aws_network_interface.db-interface.id
#   }

#     tags = {
#         Name = var.db-instance-name
#     }
# }