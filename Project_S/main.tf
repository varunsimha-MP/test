module "vpc_main" {
  source = "./modules/Networking"
}

module "ec2_main" {
    depends_on = [ module.vpc_main ]
    source = "./modules/instance"
    main_vpc = module.Networking.main_vpc_id
    subnet_id = module.Networking.public_subnet.id
    key = var.key
    instance_ingress = var.instance_ingress
    instance_egress = var.instance_egress
}

module "dns_acm" {
    depends_on = [ module.vpc_main ]
    source = "./modules/DNS"
    domain_name = var.domain_name
    subdomain_name = var.subdomain_name
    public_ip = module.ec2_main.public_ip
    acm_name = var.acm_name
}
