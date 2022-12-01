terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
    mysql = {
      source  = "winebarrel/mysql"
      version = "~>1.10"
    }
  }
}


provider "aws" {
  region = "eu-central-1"
}


module "vpc" {
  source        = "./Network"
}


module "SG" {
   source        = "./SG"
   vpc_id = module.vpc.vpc_id
}

module "EC2" {
   source        = "./EC2"
   public_subnet_ids = module.vpc.public_subnet_ids
   SG_VPC = module.SG.SG_VPC
   private_subnet_ids = module.vpc.private_subnet_ids
}

module "RDS" {
  source = "./RDS"
  database_subnet_ids = module.vpc.database_subnet_ids
  SG_RDS = module.SG.SG_RDS
}