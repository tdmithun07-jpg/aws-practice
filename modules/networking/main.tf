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

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.VPC.id

  tags = {
    Name = "3tire-igw"
  }
}

#########################
#security groups
#############################

# 1. Define the base security groups completely empty of inline rules
resource "aws_security_group" "web-sg" {
  name        = "web-sg"
  description = "Allow SSH from anywhere"
  vpc_id      = aws_vpc.VPC.id
  tags        = { Name = "web-sg" }
}

resource "aws_security_group" "app-sg" {
  name        = "app-sg"
  description = "Allow traffic from web-sg"
  vpc_id      = aws_vpc.VPC.id
  tags        = { Name = "app-sg" }
}

resource "aws_security_group" "db-sg" {
  name        = "db-sg"
  description = "Allow traffic from app-sg"
  vpc_id      = aws_vpc.VPC.id
  tags        = { Name = "db-sg" }
}

# 2. Define the cross-referenced rules standalone
resource "aws_security_group_rule" "web_allow_ssh" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  security_group_id = aws_security_group.web-sg.id
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "web_allow_http" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  security_group_id = aws_security_group.web-sg.id
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "web_allow_https" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  security_group_id = aws_security_group.web-sg.id
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "app_allow_ssh_from_web" {
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  security_group_id        = aws_security_group.app-sg.id
  source_security_group_id = aws_security_group.web-sg.id
}

resource "aws_security_group_rule" "db_allow_ssh_from_app" {
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  security_group_id        = aws_security_group.db-sg.id
  source_security_group_id = aws_security_group.app-sg.id
}

resource "aws_security_group_rule" "db_allow_ssh_from_web" {
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  security_group_id        = aws_security_group.db-sg.id
  source_security_group_id = aws_security_group.web-sg.id
}

resource "aws_security_group_rule" "db_allow_3306_from_app" {
  type                     = "ingress"
  from_port                = 3306
  to_port                  = 3306
  protocol                 = "tcp"
  security_group_id        = aws_security_group.db-sg.id
  source_security_group_id = aws_security_group.app-sg.id
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

resource "aws_route_table" "private-rt" {
  vpc_id = aws_vpc.VPC.id

  tags = {
    Name = "private-route-table"
  }
}

resource "aws_route_table_association" "app-assoc" {
  subnet_id      = aws_subnet.app-subnet.id
  route_table_id = aws_route_table.private-rt.id
}

resource "aws_route_table_association" "db-assoc" {
  subnet_id      = aws_subnet.db-subnet.id
  route_table_id = aws_route_table.private-rt.id
}


resource "aws_ec2_instance_connect_endpoint" "vpc_eice" {
  subnet_id          = aws_subnet.web-subnet.id
  security_group_ids = [aws_security_group.web-sg.id]

  tags = {
    Name = "vpc-browser-ssh-endpoint"
  }
}