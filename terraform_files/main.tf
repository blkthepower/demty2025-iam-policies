provider "aws" {
    region = "us-east-1"
}


module "iam" {
    source = "./modules/iam"
    region = "us-east-1"
}