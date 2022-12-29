terraform {
  backend "s3" {
    bucket = "terraform-state-project-00000001"
    key = "global/s3/terraform.state"
    region = "us-east-2"

    dynamodb_table = "terraform-locks-project-00000001"
    encrypt = true
  }
}

provider "aws" {
  region = local.region
}

locals {
  region = "us-east-2"
  create_vpc = true
}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "demo_vpc"
  cidr = "10.0.0.0/16"

  azs             = ["us-east-2a", "us-east-2b", "us-east-2c"]
  private_subnets = ["10.0.1.0/24", "10.0.4.0/24", "10.0.7.0/24"]
  public_subnets  = ["10.0.2.0/24", "10.0.5.0/24", "10.0.8.0/24"]
  database_subnets = ["10.0.3.0/24", "10.0.6.0/24", "10.0.9.0/24"]

  enable_nat_gateway = true

  tags = {
    Terraform = "true"
    Environment = "demo"
  }
}