
resource "aws_nat_gateway" "nat" {
  subnet_id     = aws_subnet.main.id
  allocation_id = aws_eip.nat.id

  tags = {
    Name = "${var.env}_natgw"
  }
}
