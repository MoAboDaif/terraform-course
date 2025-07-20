locals {
  vpc_names = {
    for vpc_name, config in var.vpc_config : vpc_name => index(keys(var.vpc_config), vpc_name)
  }
  private_subnet_config_map = {
    for private_subnet in local.private_subnet_configs : "${private_subnet.vpc_name}-private-subnet-${private_subnet.subnet_num}" => private_subnet
  }
  public_subnet_config_map = {
    for public_subnet in local.public_subnet_configs : "${public_subnet.vpc_name}-public-subnet-${public_subnet.subnet_num}" => public_subnet
  }
  private_subnet_configs = flatten([
    for vpc_name, config in var.vpc_config : [
      for private_subnet_index in range(config.private_subnet_count) : {
        vpc_name          = vpc_name
        vpc_index         = index(keys(var.vpc_config), vpc_name)
        subnet_num        = private_subnet_index
        availability_zone_id = data.aws_availability_zones.available.zone_ids[private_subnet_index % length(data.aws_availability_zones.available.zone_ids)]
        cidr_block        = "10.${index(keys(var.vpc_config), vpc_name)}.${private_subnet_index + 100}.0/24"
      }
    ]
  ])
  public_subnet_configs = flatten([
    for vpc_name, config in var.vpc_config : [
      for public_subnet_index in range(config.public_subnet_count) : {
        vpc_name          = vpc_name
        vpc_index         = index(keys(var.vpc_config), vpc_name)
        subnet_num        = public_subnet_index
        availability_zone_id = data.aws_availability_zones.available.zone_ids[public_subnet_index % length(data.aws_availability_zones.available.zone_ids)]
        cidr_block        = "10.${index(keys(var.vpc_config), vpc_name)}.${public_subnet_index}.0/24"
      }
    ]
  ])
}
