locals {
  azs = data.aws_availability_zone.azs.name
  private_subnet = [ for subnet in private_subnet: subnet.id]
  public_subnet = [ for subnet in public_subnet: subnet.id]
}