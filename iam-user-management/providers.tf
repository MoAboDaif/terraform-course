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
    key          = "terraform-course/iam-user-management/terraform.tfstate"
    use_lockfile = true
  }
}
provider "aws" {
  region = "eu-central-1"
}
