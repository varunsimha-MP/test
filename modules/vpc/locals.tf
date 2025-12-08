locals {
  azs = data.aws_availability_zone.azs.name
  private_subnet = [ for subnet in aws_subnet.private_subnet: subnet.id]
  public_subnet = [ for subnet in aws_subnet.private_subnet: subnet.id]
}