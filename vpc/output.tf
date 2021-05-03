output "vpc_id" {
  value = aws_vpc.vpc.id
}

output "pub_sub_id" {
  value = aws_subnet.main.id
}

output "pri_sub_id" {
  value = aws_subnet.private.id
}

output "db_sub_id" {
  value = aws_subnet.private1.id
}
