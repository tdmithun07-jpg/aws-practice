resource "aws_vpc" "VPC" {
    cidr_block = "10.0.0.0/16"
  tags = {
    Name = var.vpc-name
  }
}

resource "aws_subnet" "my_subnet" {
  vpc_id            =  aws_vpc.VPC.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-2a"

  tags = {
    Name = "subnet-1"
  }
}

