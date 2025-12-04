resource "aws_instance" "ec2" {
    ami = var.ami
    associate_public_ip_address = var.public_subnet
    instance_type = var.instance_type
    count = 2
    subnet_id = slice(var.subnet_id, count.index, count.index+1)[0]
    vpc_security_group_ids = [aws_security_group.sg_ec2.id]
    key_name = var.key
    tags = var.ec2
    user_data = file("${path.module}/userdata.sh")
}

resource "aws_security_group" "sg_ec2" {
    name = "Ec2-SG"
    description = "For allowing Ec2-SG"
    vpc_id = var.vpc_id

    dynamic "ingress" {
        for_each = var.web_ingress_rule
        content {
          description = "inbound rule"
          from_port = ingress.value.port
          to_port = ingress.value.port
          protocol = ingress.value.protocol
          cidr_blocks = ingress.value.cidr_block
        }
    }
    egress {
        from_port = 0
        to_port = 0
        protocol = -1
        cidr_blocks = ["0.0.0.0/0"]
    }
    tags = var.sg
}