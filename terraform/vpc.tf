resource "aws_vpc" "vpc" {
  cidr_block = var.cidr
}

resource "aws_subnet" "subnet" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = "11.0.0.0/24"
  availability_zone = "eu-west-1a"
}

resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.vpc.id

}

resource "aws_route_table" "RT" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id

  }
}

resource "aws_route_table_association" "rta" {
  subnet_id = aws_subnet.subnet.id
  route_table_id = aws_route_table.RT.id
}