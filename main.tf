module "vpc" {
  source = "github.com/tdmithun07-jpg/aws-practice/modules/networking"
}

module "compute" {
  source = "github.com/tdmithun07-jpg/aws-practice/modules/compute"
  vpc-id = module.vpc.vpc-id
  web-subnet-id = module.vpc.web-subnet-id 
  app-subnet-id = module.vpc.app-subnet-id
  db-subnet-id = module.vpc.db-subnet-id

  web-sg-id = module.vpc.web-sg-id
  app-sg-id = module.vpc.app-sg-id
  db-sg-id = module.vpc.db-sg-id
}