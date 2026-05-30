output "vpc-id" {
  value = module.vpc.vpc-id
}

output "web-subnet-id" {
  value = module.vpc.web-subnet-id
}
output "app-subnet-id" {
  value = module.vpc.app-subnet-id
}
output "db-subnet-id" {
  value = module.vpc.db-subnet-id
}
########################################
output "web-sg-id" {
  value = module.vpc.web-sg-id
}
output "app-sg-id" {
  value = module.vpc.app-sg-id
}
output "db-sg-id" {
  value = module.vpc.db-sg-id
}