variable "aws_region" {
  type    = string
  default = "eu-central-1"
}

variable "cluster_name" {
  type    = string
  default = "my-eks-cluster"
}

variable "vpc_cidr" {
  type    = string
  default = "10.0.0.0/16"
}

variable "node_groups" {
  type = map(object({
    instance_type = string
    desired_size  = number
    min_size      = number
    max_size      = number
  }))
  default = {
    default = {
      instance_type = "t3.medium"
      desired_size  = 2
      min_size      = 1
      max_size      = 3
    }
  }
}

variable "cluster_version" {
  type    = string
  default = "1.28"
}

# If you use multiple AZs, define availability zones (optional)
variable "availability_zones" {
  type    = list(string)
  default = []
}

