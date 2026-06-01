resource "aws_vpc" "VPC" {
    cidr_block = "10.0.0.0/16"
  tags = {
    Name = var.vpc-name
  }
}

resource "aws_subnet" "web-subnet" {
  vpc_id            =  aws_vpc.VPC.id
  cidr_block        = var.web-subnet-cidr
  availability_zone = "us-east-1a"

  tags = {
    Name = var.web-subnet
  }
}

resource "aws_subnet" "app-subnet" {
  vpc_id            =  aws_vpc.VPC.id
  cidr_block        = var.app-subnet-cidr
  availability_zone = "us-east-1b"

  tags = {
    Name = var.app-subnet
  }
}

resource "aws_subnet" "db-subnet" {
  vpc_id            =  aws_vpc.VPC.id
  cidr_block        = var.db-subnet-cidr
  availability_zone = "us-east-1c"

  tags = {
    Name = var.db-subnet
  }
}

#########################
#security groups
#############################

resource "aws_security_group" "web-sg" {
  name        = "web-sg"
  description = "Allow HTTP and SSH traffic"
  vpc_id      = aws_vpc.VPC.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "web-sg"
  }
}

resource "aws_security_group" "app-sg" {
  name        = "app-sg"
  description = "Allow traffic from web-sg"
  vpc_id      = aws_vpc.VPC.id

  ingress {
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [aws_security_group.web-sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"] 
  }
  ingress {
    from_port       = 5000
    to_port         = 5000
    protocol        = "tcp"
    security_groups = [aws_security_group.web-sg.id]
  }

  tags = {
    Name = "app-sg"
  }
}

resource "aws_security_group" "db-sg" {
  name        = "db-sg"
  description = "Allow traffic from app-sg"
  vpc_id      = aws_vpc.VPC.id

  ingress {
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [aws_security_group.app-sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.app-sg.id]
  }
  tags = {
    Name = "db-sg"
  }
}
################################################
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.VPC.id

  tags = {
    Name = "main-igw"
  }
}
######################################################
# 1. Create a Public Route Table
resource "aws_route_table" "public-rt" {
  vpc_id = aws_vpc.VPC.id

  # This route sends ALL outbound traffic (0.0.0.0/0) to your Internet Gateway
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "public-route-table"
  }
}

# 2. Associate the Route Table with your Web Subnet
resource "aws_route_table_association" "web-public-assoc" {
  subnet_id      = aws_subnet.web-subnet.id
  route_table_id = aws_route_table.public-rt.id
}

resource "aws_ec2_instance_connect_endpoint" "vpc_eice" {
  subnet_id          = aws_subnet.web-subnet.id
  security_group_ids = [aws_security_group.web-sg.id]

  tags = {
    Name = "vpc-browser-ssh-endpoint"
  }
}