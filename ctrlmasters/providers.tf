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
    bucket       = "abodaif-terraform-backend"
    key          = "ctrlmasters-calc/terraform.tfstate"
    use_lockfile = true
    region       = "eu-central-1"
  }
}