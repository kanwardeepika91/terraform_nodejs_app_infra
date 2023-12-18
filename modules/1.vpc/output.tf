output "vpc_cidr_block" {
    value = aws_vpc.myvpc
}

output "vpc_id" {
  value = aws_vpc.myvpc.id
}

output "public_subnet_id_1" {
  value = aws_subnet.public_subnet_1_cidr
}

output "public_subnet_id_2" {
  value = aws_subnet.public_subnet_2_cidr
}

output "private_subnet_id_1" {
  value = aws_subnet.private_subnet_1_cidr.id
} 
output "private_subnet_id_2" {
  value = aws_subnet.private_subnet_2_cidr.id
} 