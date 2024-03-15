# gateway to connect to outside world
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

}

# eip provides a stable public ip to nat_gateway
resource "aws_eip" "nat_1" {
  depends_on = [aws_internet_gateway.igw]
}

resource "aws_eip" "nat_2" {
  depends_on = [aws_internet_gateway.igw]
}

# provides a gateway for private subnet resources to connect to public subnet resources(alb)
resource "aws_nat_gateway" "nat_gw_1" {
  allocation_id = aws_eip.nat_1.id
  subnet_id     = aws_subnet.public-us-east-1a.id
}

resource "aws_nat_gateway" "nat_gw_2" {
  allocation_id = aws_eip.nat_2.id
  subnet_id     = aws_subnet.public-us-east-1b.id
}