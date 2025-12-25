# -------------------
# Network
# -------------------

main_vpc = {
  Name = "main-vpc"
}

main_ig = {
  Name = "main-igw"
}

cidr_block = "11.0.0.0/16"  

route_table = {
  Name  = "app-rt"
}

# -------------------
# Subnets
# -------------------

pub_subnet_name = "Public-subnet"
pri_subnet_name = "Private-subnet"

pub_sub_cidr_block = [
  "11.0.0.0/19",
  "11.0.32.0/19",
  "11.0.64.0/19"
]

pri_sub_cidr_block = [
  "11.0.96.0/19",
  "11.0.128.0/19",
  "11.0.160.0/19"
]

pub_subnet_count = 3
pri_subnet_count = 3

# -------------------
# NAT & EIP
# -------------------

eip = {
  Name = "nat-eip"
}

nat = {
  Name = "nat-gateway"
}

# -------------------
# VPC Endpoints
# -------------------

s3_endpoint = {
  Name        = "s3-endpoint"
  service     = "s3"
  type        = "Gateway"
}

secret_endpoint = {
  Name        = "secretsmanager-endpoint"
  service     = "secretsmanager"
  type        = "Interface"
}

api_endpoint = {
  Name        = "execute-api-endpoint"
  service     = "execute-api"
  type        = "Interface"
}
