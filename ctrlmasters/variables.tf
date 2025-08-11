variable "aws_region" {
  type    = string
  default = "eu-central-1"
}

variable "application_name" {
  type    = string
  default = "ctrlmasters-calculator"
}

variable "vpc_cidr" {
  type    = string
  default = "10.0.0.0/16"
}

variable "public_subnets" {
  type    = list(string)
  default = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}

variable "private_subnets" {
  type    = list(string)
  default = ["10.0.11.0/24", "10.0.12.0/24", "10.0.13.0/24", "10.0.14.0/24", "10.0.15.0/24", "10.0.16.0/24"]
}

variable "tags" {
  type = map(string)
  default = {
    Terraform = "true"
  }
}

