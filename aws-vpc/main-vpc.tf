resource "aws_vpc" "main_vpc" {
  for_each             = local.vpc_names
  cidr_block           = "10.${each.value}.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = each.key
  }
}
resource "aws_subnet" "private_subnet" {
  for_each   = local.private_subnet_config_map
  vpc_id     = aws_vpc.main_vpc[each.value.vpc_name].id
  cidr_block = each.value.cidr_block
  availability_zone_id = each.value.availability_zone_id
  tags = {
    "Index" = each.value.vpc_index
    "Name"  = each.key
  }
}
resource "aws_subnet" "public_subnet" {
  for_each   = local.public_subnet_config_map
  vpc_id     = aws_vpc.main_vpc[each.value.vpc_name].id
  cidr_block = each.value.cidr_block
  map_public_ip_on_launch = true
  availability_zone_id = each.value.availability_zone_id
  tags = {
    "Index" = each.value.vpc_index
    "Name"  = each.key
  }
}
# output "vpc_names" {
#   value = local.vpc_names
# }
# output "private_subnet_configs" {
#   value = local.private_subnet_config_map
# }
# output "public_subnet_configs" {
#   value = local.public_subnet_config_map
# }
output "zone_id" {
  value = data.aws_availability_zones.available
}