terraform {
  required_version = "~> 1.10"
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 6.0"
    }
    random = {
      source = "hashicorp/random"
      version = "~> 3.0"
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
  bucket_prefix = "moabodaif-terraform-${terraform.workspace}-bucket-"
}

resource "random_id" "bucket_suffix" {
  byte_length = 6
}

resource "aws_s3_bucket" "workspaced" {
  bucket = "moabodaif-terraform-${terraform.workspace}-${random_id.bucket_suffix.hex}"
}

# import {
#   to = aws_s3_bucket.backend
#   id = "moabodaif-terraform-bucket"
# }

# resource "aws_s3_bucket" "backend" {
#   bucket = "moabodaif-terraform-bucket"
# }

# removed {
#   from = aws_s3_bucket.backend
#   lifecycle {
#     destroy = false
#   }
# }