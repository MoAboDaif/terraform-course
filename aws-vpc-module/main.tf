terraform {
  required_version = "~> 1.12"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
  backend "s3" {
    bucket       = "moabodaif-terraform-bucket"
    key          = "terraform-course/aws-vpc-module"
    use_lockfile = true
  }
}
provider "aws" {
  region = "eu-central-1"
}
module "aws_vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "6.0.1"
  default_vpc_enable_dns_hostnames = true
  default_vpc_enable_dns_support = true
  default_vpc_name = "default_vpc"
  default_vpc_tags = {}
  manage_default_vpc = true
  create_vpc = false
}
data "aws_availability_zones" "available"{
  state = "available"
}