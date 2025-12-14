module "vpc_main" {
  source = "./modules/Networking"
  vpc = var.vpc
  cidr_block = var.cidr_block
  main_ig = var.main_ig
  sub_count = var.sub_count
  route_table = var.route_table
  pub_subnet_name = var.pub_subnet_name
  pub_sub_cidr_block = var.pub_sub_cidr_block
  pri_subnet_name = var.pri_subnet_name
  pri_sub_cidr_block = var.pri_sub_cidr_block
}

module "ec2_main" {
    depends_on = [ module.vpc_main ]
    source = "./modules/instance"
    main_vpc = module.vpc_main.main_vpc
    subnet_id = module.vpc_main.pub_subnet
    key_name = var.key_name
    instance_ingress = var.instance_ingress
    instance_egress = var.instance_egress
    sg_name = var.sg_name
    sg_description = var.sg_description
    sg_tag_name = var.sg_tag_name
    instance_count = var.instance_count
    instance_name = var.instance_name
    instance_type = var.instance_type
    ami = var.ami
}

module "dns_acm" {
    depends_on = [ module.vpc_main ]
    source = "./modules/DNS"
    domain_name = var.domain_name
    subdomain_name = var.subdomain_name
    public_ip = module.ec2_main.public_ip
    acm_name = var.acm_name
}
