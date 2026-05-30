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
