resource "aws_internet_gateway" "internet" {
  vpc_id = aws_vpc.vois.id

  tags = {
    Name = "internet"

  }
}