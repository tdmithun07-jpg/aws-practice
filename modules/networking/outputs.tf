output "vpc-id" {
  value = aws_vpc.VPC.id
}

output "web-subnet-id" {
  value = aws_subnet.web-subnet.id
}

output "app-subnet-id" {
  value = aws_subnet.app-subnet.id
}

output "db-subnet-id" {
  value = aws_subnet.db-subnet.id
}
################################################
#security group outputs
################################################
output "web-sg-id" {
  value = aws_security_group.web-sg.id
}
output "app-sg-id" {
  value = aws_security_group.app-sg.id
}
output "db-sg-id" {
  value = aws_security_group.db-sg.id
}

output "igw-id" {
  value = aws_internet_gateway.igw.id
}