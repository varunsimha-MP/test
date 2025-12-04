locals {
  azs = data.aws_availability_zone.azs.names 
  private_subnet = [ for subnet in aws_private_subnet: subnet.id]
  public_subnet = [ for subnet in aws_public_subnet: subnet.id]
}