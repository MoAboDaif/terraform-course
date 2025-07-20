terraform {
  required_version = "~> 1.12"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }
  }
  backend "s3" {
    bucket  = "moabodaif-terraform-bucket"
    key     = "terraform-course/aws-vpc/terraform.tfstate"
    region  = "eu-central-1"
    encrypt = true
  }
}
provider "aws" {
  region = "eu-central-1"
}
provider "random" {}