variable "vpc_config" {
  type = map(object({
    public_subnet_count  = number
    private_subnet_count = number
    })
  )
  default = {
    "main_vpc" = {
      public_subnet_count  = 2
      private_subnet_count = 4
    }
  }
  validation {
    condition = alltrue([
      for vpc_name, config in var.vpc_config : config.public_subnet_count <= length(data.aws_availability_zones.available.names)
    ])
    error_message = "only one public subnet can be created in each availability zone, \nPlease adjust the public_subnet_count accordingly."
  }
}
