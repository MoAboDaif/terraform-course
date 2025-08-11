data "aws_availability_zones" "available" {
  state = "available"
}

data "aws_ami" "os_image" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-*-amd64-server-*"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

data "aws_eip" "calculator_server_eip" {
  id = "eipalloc-0b08feff0613236fd"
}