resource "aws_internet_gateway" "hw20" {
  vpc_id = aws_vpc.hw20.id

  tags = {
    Name = "hw20-igw"
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.hw20.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.hw20.id
  }

  tags = {
    Name = "hw20-public-rt"
  }
}