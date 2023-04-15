resource "aws_vpc" "vois" {
  cidr_block       = "30.0.0.0/16"

  tags = {
    Name = "vois"
  }
}