output "vpc_id" {
  value = aws_vpc.my_vpc.id
}

output "public_subnet_id" {
  value = {
    for key, subnet in aws_subnet.public_subnet: key =>subnet.id
  }
}