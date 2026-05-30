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
