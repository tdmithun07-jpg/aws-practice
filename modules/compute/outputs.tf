output "web-network-interface-id" {
  value = aws_network_interface.web-interface.id
}
output "app-network-interface-id" {
  value = aws_network_interface.app-interface.id
}
output "db-network-interface-id" {
  value = aws_network_interface.db-interface.id
}