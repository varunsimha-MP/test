#Root module

domain_name = "simha.in.net"
subdomain_name = "subsimha.in.net"

instance_egress = {
  "all_out" = {
    port = 0
    protocol = "-1"
    cidr_block = "[0.0.0.0/0]"
    description = "Allow all outbound rule"
  }
}

instance_ingress = {
  "SSH" = {
    port = 22
    protocol = "tcp"
    cidr_block = "[0.0.0.0/0]"
    description = "Allow SSH inbound rule"
  }
  "HTTP" = {
    port = 80
    protocol = "http"
    cidr_block = "[0.0.0.0/0]"
    description = "Allow HTTP inbound rule"
  }
  "HTTPS" = {
    port = 443
    protocol = "https"
    cidr_block = "[0.0.0.0/0]"
    description = "Allow HTTPS inbound rule"
  }
}

acm_name = {
  name = "simha certificate"
  environment = "Test"
}

key_name = {
  Name = "test_singapore"
}

#Networking Module
vpc = {
    Name = "main_vpc"
}

cidr_block = "10.0.0.0/16"

main_ig = {
    Name = "main_internet_gateway"
}

route_table = {
    Name = "App_RT"
}

sub_count = 2
pub_subnet_name = "Public Subnet"
pub_sub_cidr_block = ["10.0.1.0/24", "10.0.2.0/24"]

pri_subnet_name = "Private Subnet"
pri_sub_cidr_block = ["10.0.3.0/24", "10.0.4.0/24"]


#Instance module

ami = "ami-00d8fc944fb171e29"
instance_type = "t2.micro"
instance_count = 2
key_name = "Test-Terraform"
instance_name = "Test-Server"
sg_tag_name = {
    Name = "App_RT-SG"
}
sg_name         = "instance-security-group"
sg_description  = "Security group for EC2 instance"