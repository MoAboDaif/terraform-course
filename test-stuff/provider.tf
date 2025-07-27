terraform {
  required_version = "~> 1.10"
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
  backend "s3" {
    bucket = "moabodaif-terraform-bucket"
    key = "terraform-course/test-stuff/terraform.tfstate"
    dynamodb_table = "terraform-locks"
    region = "eu-central-1"
  }
}
provider "aws" {
  region = "eu-central-1"  
}

resource "aws_s3_bucket" "this" {
  bucket_prefix = "moabodaif-terraform-bucket-prefix"
}