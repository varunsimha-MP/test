# -------------------
# Network
# -------------------

main_vpc = {
  name = "main-vpc"
}

main_ig = {
  name = "main-igw"
}

cidr_block = "11.0.0.0/16"   # Used for VPC CIDR like 10.0.0.0/16

route_table = {
  public  = "app-rt"
}

# -------------------
# Subnets
# -------------------

pub_subnet_name = "public-subnet"
pri_subnet_name = "private-subnet"

pub_sub_cidr_block = [
  "11.0.0.0/19",
  "11.0.32.0/19",
  "11.0.64.0/19"
]

pri_sub_cidr_block = [
  "11.0.96.0/11",
  "11.0.128.0/11",
  "11.0.160.0/11"
]

pub_subnet_count = 3
pri_subnet_count = 3

# -------------------
# NAT & EIP
# -------------------

eip = {
  name = "nat-eip"
}

nat = {
  name = "nat-gateway"
}

# -------------------
# VPC Endpoints
# -------------------

s3_endpoint = {
  name        = "s3-endpoint"
  service     = "s3"
  type        = "Gateway"
}

secret_endpoint = {
  name        = "secretsmanager-endpoint"
  service     = "secretsmanager"
  type        = "Interface"
}

api_endpoint = {
  name        = "execute-api-endpoint"
  service     = "execute-api"
  type        = "Interface"
}
