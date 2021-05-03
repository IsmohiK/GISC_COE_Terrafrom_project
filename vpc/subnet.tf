
resource "aws_subnet" "main" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = var.subnet
  availability_zone = var.az[0]

  tags = {
    Name = "${var.env}_public_subnet"
  }
}


resource "aws_subnet" "private" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = var.subnet1
  availability_zone = var.az[0]

  tags = {
    Name = "${var.env}_private_subnet"
  }
}


resource "aws_subnet" "private1" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = var.subnet2
  availability_zone = var.az[2]

  tags = {
    Name = "${var.env}_db_subnet"
  }
}


