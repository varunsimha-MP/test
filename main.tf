module "vpc" {
    source = "./modules/vpc" 
}

module "ec2" {
    depends_on = [ module.vpc ]
    source = "./modules/ec2" 
    key = "mum_private_key"
    vpc_id = module.vpc.main_vpc_id
    subnet_id = module.vpc.pub_subnet_id
    web_ingress_rule = {
        "80" = {
            port = 80
            protocol = "tcp"
            description = "Allow HTTP access"
            cidr_block = ["0.0.0.0/0"]
        }
        "22" = {
            port = 22
            protocol = "tcp"
            description = "Allow SSH access"
            cidr_block = ["0.0.0.0/0"]
        }
        "icmp" = {
            port = 0
            protocol = "-1"
            description = "Allow ping access"
            cidr_block = ["0.0.0.0/0"]

        }
    }
}