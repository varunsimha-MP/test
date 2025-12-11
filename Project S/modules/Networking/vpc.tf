resource "aws_vpc" "main_vpc" {
  cidr_block = var.cidr_block
  instance_tenancy = "default"
  tags = var.vpc
  enable_dns_hostnames = true
  enable_dns_support = true
}

resource "aws_internet_gateway" "main_ig" {
    vpc_id = aws_vpc.main_vpc.id
    tags = var.main_ig
}

resource "aws_route_table" "main_route_table" {
    vpc_id = aws_vpc.main_vpc.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.main_ig.id
    }
    tags = var.route_table
}

resource "aws_subnet" "public_subnet" {
    vpc_id = aws_vpc.main_vpc.id
    count = var.sub_count
    availability_zone = local.azs[count.index]
    cidr_block = var.pub_sub_cidr_block[count.index]
    map_public_ip_on_launch = true
    tags = {
        Name = "${var.pub_subnet_name}-${count.index}"
    }
}

resource "aws_subnet" "private_subnet" {
    vpc_id = aws_vpc.main_vpc.id
    count = var.sub_count
    availability_zone = local.azs[count.index]
    cidr_block = var.pri_sub_cidr_block[count.index]
    tags = {
        Name = "${var.pri_subnet_name}-${count.index}"
    }
}