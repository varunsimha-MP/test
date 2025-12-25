resource "aws_vpc" "main_vpc" {
    cidr_block = var.cidr_block
    instance_tenancy = "default"
    enable_dns_hostnames = true
    enable_dns_support = true
    tags = var.main_vpc  
}

resource "aws_internet_gateway" "main_ig" {
    vpc_id = aws_vpc.main_vpc.id
    tags = var.main_ig
    depends_on = [ aws_vpc.main_vpc ]
}

resource "aws_route_table" "public_rt" {
    vpc_id = aws_vpc.main_vpc.id 
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.main_ig.id
    }
    tags = var.public_route_table
    depends_on = [ aws_vpc.main_vpc ]
}

resource "aws_subnet" "public_subnet" {
    vpc_id = aws_vpc.main_vpc.id
    count = var.pub_subnet_count
    availability_zone = local.azs[count.index]
    cidr_block = var.pub_sub_cidr_block[count.index]
    map_public_ip_on_launch = true 
    tags = {
        Name = "${var.pub_subnet_name}-${count.index}"
    }
    depends_on = [ aws_vpc.main_vpc ]
}

resource "aws_route_table_association" "pub_subnet_to_route" {
    count = var.pub_subnet_count
    route_table_id = aws_route_table.public_rt.id
    subnet_id = aws_subnet.public_subnet[count.index].id
    depends_on = [ aws_vpc.main_vpc ]
}

resource "aws_subnet" "private_subnet" {
    vpc_id = aws_vpc.main_vpc.id
    count = var.pri_subnet_count
    availability_zone = local.azs[count.index]
    cidr_block = var.pri_sub_cidr_block[count.index]
    tags = {
        Name = "${var.pri_subnet_name}-${count.index}"
    }
    depends_on = [ aws_vpc.main_vpc ]
}

resource "aws_route_table_association" "pri_subnet_to_route" {
    count = var.pri_subnet_count
    route_table_id = aws_route_table.private_rt.id
    subnet_id = aws_subnet.private_subnet[count.index].id
    depends_on = [ aws_vpc.main_vpc ]
}

resource "aws_route_table" "private_rt" {
    vpc_id = aws_vpc.main_vpc.id 
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_nat_gateway.nat.id
    }
    tags = var.private_route_table
    depends_on = [ aws_vpc.main_vpc ]
}

resource "aws_eip" "eip" {
    domain = "vpc"
    tags = var.eip
    depends_on = [ aws_vpc.main_vpc ]
}

resource "aws_nat_gateway" "nat" {
    connectivity_type = "public"
    allocation_id = aws_eip.eip.id
    subnet_id = aws_subnet.public_subnet[0].id
    tags = var.nat
    depends_on = [ aws_vpc.main_vpc ]
}

resource "aws_vpc_endpoint" "S3_endpoint" {
    vpc_id = aws_vpc.main_vpc.id
    service_name = "com.amazonaws.ap-southeast-1.s3"
    vpc_endpoint_type = "Gateway"
    route_table_ids = [aws_route_table.private_rt.id]
    tags = var.s3_endpoint
    depends_on = [ aws_vpc.main_vpc ]
}

resource "aws_vpc_endpoint" "api_endpoint" {
    vpc_id = aws_vpc.main_vpc.id
    service_name = "com.amazonaws.ap-southeast-1.execute-api"
    vpc_endpoint_type = "Interface"
    subnet_ids = [ aws_subnet.private_subnet[0].id ]
    private_dns_enabled = true
    tags = var.api_endpoint
    depends_on = [ aws_vpc.main_vpc ]
}

resource "aws_vpc_endpoint" "secret_endpoint" {
    vpc_id = aws_vpc.main_vpc.id 
    service_name = "com.amazonaws.ap-southeast-1.secretsmanager"
    vpc_endpoint_type = "Interface"
    subnet_ids = [ aws_subnet.private_subnet[0].id ]
    private_dns_enabled = true 
    tags = var.secret_endpoint
    depends_on = [ aws_vpc.main_vpc ]
}

resource "aws_security_group" "this" {
    for_each = var.security_groups
    name = each.key
    description = each.value.description
    vpc_id = aws_vpc.main_vpc.id 

    dynamic "ingress" {
        for_each = each.value.ingress
        content {
          from_port = ingress.value.from_port
          to_port = ingress.value.to_port
          protocol = ingress.value.protocol
          cidr_blocks = lookup(ingress.value, "cidr_block", null)
          security_groups = ingress.value.sg_refs != null ? [for sg in ingress.value.sg_refs : local.sg_map[sg]] : null
        }
      
    }
    dynamic "egress" {
        for_each = lookup(each.value, "egress", [
            {
                from_port = 0
                to_port = 0
                protocol = "-1"
                cidr_blocks = ["0.0.0.0/0"]
            }
        ])
        content {
          from_port = egress.value.from_port
          to_port = egress.value.to_port
          protocol = egress.value.protocol
          cidr_blocks = lookup(egress.value, "cidr_block", null)
          security_groups = lookup(egress.value, "sg_refs", null) != null ? [for sg in egress.value.sg_refs: local.sg_map[sg]]: null
        }
      
    }
    tags = {
        Name = each.key
    }
  
}