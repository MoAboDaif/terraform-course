provider "aws" {
  region = "eu-central-1"
}
resource "aws_vpc" "main-vpc" {
  cidr_block = "10.0.0.0/16"
  enable_dns_support = true
  enable_dns_hostnames = true
  tags = {
    Name = "Terraform VPC"
    Environment = "Learning"
    Terraform = "true"
  }
}
resource "aws_internet_gateway" "main-igw" {
  vpc_id = aws_vpc.main-vpc.id
  tags = {
    Name = "Terraform IGW"
    Environment = "Learning"
    Terraform = "true"
  }
}
resource "aws_subnet" "Public-subnet-01" {
  vpc_id = aws_vpc.main-vpc.id
  cidr_block = "10.0.0.0/24"
  availability_zone = data.aws_availability_zones.available.names[0]
  map_public_ip_on_launch = true
  tags = {
    Name = "${aws_vpc.main-vpc.tags.Name} Public Subnet 01"
    Environment = "Learning"
    Terraform = "true"
  }
}
resource "aws_subnet" "Public-subnet-02" {
  vpc_id = aws_vpc.main-vpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone = data.aws_availability_zones.available.names[1]
  map_public_ip_on_launch = true
  tags = {
    Name = "${aws_vpc.main-vpc.tags.Name} Public Subnet 02"
    Environment = "Learning"
    Terraform = "true"
  }
}
resource "aws_subnet" "Public-subnet-03" {
  vpc_id = aws_vpc.main-vpc.id
  cidr_block = "10.0.2.0/24"
  availability_zone = data.aws_availability_zones.available.names[2]
  map_public_ip_on_launch = true
  tags = {
    Name = "${aws_vpc.main-vpc.tags.Name} Public Subnet 03"
    Environment = "Learning"
    Terraform = "true"
  }
}
resource "aws_subnet" "Private-subnet-01" {
  vpc_id = aws_vpc.main-vpc.id
  cidr_block = "10.0.3.0/24"
  availability_zone = data.aws_availability_zones.available.names[0]
  map_public_ip_on_launch = false
  tags = {
    Name = "${aws_vpc.main-vpc.tags.Name} Private Subnet 01"
    Environment = "Learning"
    Terraform = "true"
  }
}
resource "aws_subnet" "Private-subnet-02" {
  vpc_id = aws_vpc.main-vpc.id
  cidr_block = "10.0.4.0/24"
  availability_zone = data.aws_availability_zones.available.names[1]
  map_public_ip_on_launch = false
  tags = {
    Name = "${aws_vpc.main-vpc.tags.Name} Private Subnet 02"
    Environment = "Learning"
    Terraform = "true"
  }
}
resource "aws_subnet" "Private-subnet-03" {
  vpc_id = aws_vpc.main-vpc.id
  cidr_block = "10.0.5.0/24"
  availability_zone = data.aws_availability_zones.available.names[2]
  map_public_ip_on_launch = false
  tags = {
    Name = "${aws_vpc.main-vpc.tags.Name} Private Subnet 03"
    Environment = "Learning"
    Terraform = "true"
  }
}
resource "aws_route_table" "Public-rtb" {
  vpc_id = aws_vpc.main-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main-igw.id
  }
}
resource "aws_route_table_association" "Public-subnet-01-assoc" {
  subnet_id = aws_subnet.Public-subnet-01.id
  route_table_id = aws_route_table.Public-rtb.id
}
resource "aws_route_table_association" "Public-subnet-02-assoc" {
  subnet_id = aws_subnet.Public-subnet-02.id
  route_table_id = aws_route_table.Public-rtb.id
}
resource "aws_route_table_association" "Public-subnet-03-assoc" {
  subnet_id = aws_subnet.Public-subnet-03.id
  route_table_id = aws_route_table.Public-rtb.id
}
data "aws_availability_zones" "available" {
  state = "available"
}