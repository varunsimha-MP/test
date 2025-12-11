output "main_vpc" {
    value = aws_vpc.main_vpc.id
}

output "pub_subnet" {
    value = aws_subnet.public_subnet.id
}

output "pri_subnet" {
    value = aws_subnet.private_subnet.id
}