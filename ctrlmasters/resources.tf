module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 6.0"

  name = "${terraform.workspace}-${var.application_name}-vpc"
  cidr = var.vpc_cidr

  azs             = data.aws_availability_zones.available.names
  public_subnets  = var.public_subnets
  private_subnets = var.private_subnets

  enable_nat_gateway = false
  single_nat_gateway = false
  enable_vpn_gateway = false

  map_public_ip_on_launch = true

  tags = local.tags

}

module "calculator_server" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 6.0"

  name = "calculator-server"
  ami = data.aws_ami.os_image.id

  instance_type = "t2.micro"
  subnet_id     = module.vpc.public_subnets[0]
  key_name      = "Kubernetes"

  security_group_ingress_rules = {
    http = {
      cidr_ipv4   = "0.0.0.0/0"
      ip_protocol = "tcp"
      from_port   = 80
      to_port     = 80
    }
    https = {
      cidr_ipv4   = "0.0.0.0/0"
      ip_protocol = "tcp"
      from_port   = 443
      to_port     = 443
    }
    ssh = {
      cidr_ipv4   = "0.0.0.0/0"
      ip_protocol = "tcp"
      from_port   = 22
      to_port     = 22
    }
    backend = {
      cidr_ipv4   = "0.0.0.0/0"
      ip_protocol = "tcp"
      from_port   = 5000
      to_port     = 5000
    }
    frontend = {
      cidr_ipv4   = "0.0.0.0/0"
      ip_protocol = "tcp"
      from_port   = 3000
      to_port     = 3000
    }
  }

  user_data = file("${path.module}/scripts/user_data.sh")

  tags = local.tags

}

resource "aws_eip_association" "attach_existing" {
  allocation_id = data.aws_eip.calculator_server_eip.id
  instance_id   = module.calculator_server.id
}
