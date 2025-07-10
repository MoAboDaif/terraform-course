terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
  # backend "s3" {
  #   bucket         = "abodaif-terraform-course"
  #   key            = "aws-vpc/terraform.tfstate"
  #   region         = "eu-central-1"
  # }
  required_version = ">= 1.2"
}