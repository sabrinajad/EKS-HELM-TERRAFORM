
resource "aws_nat_gateway" "nat" {
allocation_id = aws_eip.nat.id  #elastic-ip 
subnet_id     = aws_subnet.pub1.id    #public

  tags = {
    Name = "nat"
  }
  depends_on = [aws_internet_gateway.internet]
}