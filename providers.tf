terraform {
 required_providers {
    aws = { 
        source = "hashicorp/aws" 
        version = "6.36.0"
       
     } 
   } 

cloud {
    organization = "AWS-proj"
    workspaces {
      name = "AWS-infra"
    }
   }
}
provider "aws" { # Configuration options }
 region = "us-east-1"
}

# terraform {
#   required_providers {
#     aws = { 
#       source  = "hashicorp/aws" 
#       version = "6.36.0"
#     } 
#   } 
# }

# provider "aws" {
#   region     = "us-east-1"
#   access_key = "AKIAUFNC336YBPI4CODB"     # Correct parameter name
#   secret_key = "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" # Correct parameter name
# }
