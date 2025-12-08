resource "aws_vpc" "main_vpc" {
    cidr_block = var.cidr_block
    instance_tenancy = "default"
    enable_dns_hostnames = true
    enable_dns_support = true
    tags = var.vpc
}

resource "aws_internet_gateway" "main_ig" {
    depends_on = [ aws_vpc.main_vpc ]
    vpc_id = aws_vpc.main_vpc.id
    tags = var.main_ig 
}

resource "aws_route_table" "main_route_table" {
    depends_on = [ aws_vpc.main_vpc ]
    vpc_id = aws_vpc.main_vpc.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.main_ig.id
    }
    tags = var.main_route 
}

resource "aws_subnet" "public_subnet" {
    depends_on = [ aws_vpc.main_vpc ]
    count = var.subnet_count
    vpc_id = aws_vpc.main_vpc.id
    availability_zone = local.azs[count.index]
    cidr_block = var.pub_cidr[count.index]
    map_public_ip_on_launch = true
    tags = var.pub_subnet
}

resource "aws_subnet" "private_subnet" {
    depends_on = [ aws_vpc.main_vpc ]
    vpc_id = aws_vpc.main_vpc.id
    count = var.subnet_count
    availability_zone = local.azs[count.index]
    cidr_block = var.cidr_block[count.index]
    tags = var.pri_subnet
}

resource "aws_route_table_association" "pub_rt_associate" {
    count = var.subnet_count
    subnet_id = aws_subnet.public_subnet.*.id[count.index]
    route_table_id = aws_route_table.main_route_table.id
}

resource "aws_route_table_association" "pri_rt_associate" {
    count = var.subnet_count
    subnet_id = aws_subnet.private_subnet.*.id[count.index]
    route_table_id = aws_route_table.main_route_table.id  
}