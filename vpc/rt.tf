resource "aws_route_table" "gisc_terraform_vpc_rt" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

 
  route {
    cidr_block = "10.0.0.0/24"
    vpc_peering_connection_id = "pcx-0e5c83fc302e734bd"
  }  

  tags = {
    Name = "public rt"
  }
}


resource "aws_route_table" "gisc_terraform_vpc_private_rt" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id  = aws_nat_gateway.nat.id
  }

 
  route {
    cidr_block = "10.0.0.0/24"
    vpc_peering_connection_id = "pcx-0e5c83fc302e734bd"
  }

  tags = {
    Name = "private rt"
  }
}

resource "aws_route_table_association" "gisc_terraform_vpc_rt_association" {
  subnet_id      = aws_subnet.main.id
  route_table_id = aws_route_table.gisc_terraform_vpc_rt.id
}


resource "aws_route_table_association" "gisc_terraform_vpc_rt_private_association" {
  subnet_id      = aws_subnet.private.id
  route_table_id = aws_route_table.gisc_terraform_vpc_private_rt.id
}



resource "aws_route_table_association" "gisc_terraform_vpc_rt_db_association" {
  subnet_id      = aws_subnet.private1.id
  route_table_id = aws_route_table.gisc_terraform_vpc_private_rt.id
}
