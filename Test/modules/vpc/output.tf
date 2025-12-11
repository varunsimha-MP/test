output "pri_subnet_id" {
  value = local.private_subnet
}

output "pub_subnet_id" {
    value = local.public_subnet
}

output "main_vpc_id" {
    value = aws_vpc.main_vpc.id
}