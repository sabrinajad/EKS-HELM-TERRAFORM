resource "aws_route_table" "pub-rt" {    ##add route
  vpc_id = aws_vpc.vois.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet.id
  }

  tags = {
    Name = "pub-rt"
  }
}

resource "aws_route_table" "prv-rt" {
  vpc_id = aws_vpc.vois.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat.id
  }

  tags = {
    Name = "prv-rt"
  }
}
