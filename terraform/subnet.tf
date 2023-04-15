resource "aws_subnet" "pub1" {
  vpc_id     = aws_vpc.vois.id
  cidr_block = "30.0.1.0/24"
  availability_zone       = "us-east-1a"

  tags = {
    Name = "pub1"
     "kubernetes.io/role/elb"     = "1"  #to tell Kubernetes where to deploy internal Load Balancer incase we use old terraform version but now it know private and public auto)
    "kubernetes.io/cluster/demo" = "owned"  # dont allows more than this cluster to use this VPC
  }
}
resource "aws_subnet" "prv1" {
  vpc_id     = aws_vpc.vois.id
  cidr_block = "30.0.2.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "prv1"
     "kubernetes.io/role/internal-elb"     = "1" #to tell Kubernetes where to deploy external Load Balancer 
    "kubernetes.io/cluster/demo" = "owned"
  }
}
resource "aws_subnet" "pub2" {
  vpc_id     = aws_vpc.vois.id
  cidr_block = "30.0.3.0/24"
  availability_zone       = "us-east-1b"

  tags = {
    Name = "pub2"
     "kubernetes.io/role/elb"     = "1"
    "kubernetes.io/cluster/demo" = "owned"
  }
}
resource "aws_subnet" "prv2" {
  vpc_id     = aws_vpc.vois.id
  cidr_block = "30.0.4.0/24"
  availability_zone = "us-east-1b"

  tags = {
    Name = "prv2"
     "kubernetes.io/role/internal-elb"     = "1"
    "kubernetes.io/cluster/demo" = "owned"
  }
}
