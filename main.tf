module "vpc" {
  source = "github.com/tdmithun07-jpg/aws-practice/modules/networking"
}

module "compute" {
  source = "github.com/tdmithun07-jpg/aws-practice/modules/compute"
  vpc_id = module.vpc.vpc-id
  web-subnet-id = module.vpc.web-subnet-id 
  app-subnet-id = module.vpc.app-subnet-id
  db-subnet-id = module.vpc.db-subnet-id
}