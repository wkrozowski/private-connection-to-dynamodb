terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }

  required_version = ">= 0.14.9"
}

provider "aws" {
  region = "us-east-1"
}

data "aws_availability_zones" "available" {
  state = "available"
}

module "vpc" {
  name    = "my-vpc"
  source  = "terraform-aws-modules/vpc/aws"
  version = "2.64.0"

  cidr = "10.0.0.0/16"

  azs            = ["us-east-1a", "us-east-1b", "us-east-1c"]
  public_subnets = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

  enable_nat_gateway = true
  enable_vpn_gateway = false
}





