resource "aws_instance" "main_instance" {
    count = var.instance_count
    ami = var.ami
    associate_public_ip_address = true
    instance_type = var.instance_type
    subnet_id = slice(var.subnet_id, count.index, count.index+1)[0]
    key_name = var.key_name
    vpc_security_group_ids = [aws_security_group.main_sg.id]
    user_data = file("${path.module}/userdata.sh")
    tags = {
      Name = "${var.instance_name}-${count.index}"
    }
}

resource "aws_security_group" "main_sg" {
    name = var.sg_name
    description = var.sg_description
    vpc_id = var.main_vpc
    dynamic "ingress" {
      for_each = var.instance_ingress 
        content {
          description = ingress.value.description
          from_port = ingress.value.port 
          to_port = ingress.value.port
          cidr_blocks = ingress.value.cidr_block
          protocol = ingress.value.protocol
        }
    }
    dynamic "egress" {
      for_each = var.instance_egress
      content {
        description = egress.value.description
        from_port = egress.value.port
        to_port = egress.value.port 
        protocol = egress.value.protocol
        cidr_blocks = egress.value.cidr_block
      } 
      
    }
    tags = var.sg_tag_name
}