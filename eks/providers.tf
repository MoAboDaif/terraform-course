terraform {
  required_version = ">= 1.3.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 6.0"
    }
  }
  backend "s3" {
    bucket = "moabodaif-terraform-s3-backend"
    key = "eks_cluster.tfstate"
    region = "eu-central-1"
    use_lockfile = true
  }
}


provider "aws" {
  region = var.aws_region
}
