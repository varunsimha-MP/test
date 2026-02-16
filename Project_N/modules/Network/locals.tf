locals {
  azs = data.aws_availability_zones.azs.names
}

locals {
  sg_map = {
    for name, sg in aws_security_group.this :
    name => sg.id
  }
}