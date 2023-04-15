resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.pub1.id
  route_table_id = aws_route_table.pub-rt.id
}


resource "aws_route_table_association" "b" {
  subnet_id      = aws_subnet.pub2.id
  route_table_id = aws_route_table.pub-rt.id
}
#======================================
resource "aws_route_table_association" "c" {
  subnet_id      = aws_subnet.prv1.id
  route_table_id = aws_route_table.prv-rt.id
}

resource "aws_route_table_association" "d" {
  subnet_id      = aws_subnet.prv2.id
  route_table_id = aws_route_table.prv-rt.id
}
