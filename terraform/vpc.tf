resource "aws_vpc" "vpc" {
  cidr_block           = "11.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
}

# public subnet for the alb
resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = "11.0.0.0/24"
  availability_zone       = "eu-west-1a"
  map_public_ip_on_launch = true
  tags = {
    "Name"                            = "public-eu-west-1a"
    "kubernetes.io/role/internal-elb" = "1"
    "kubernetes.io/cluster/chatbot"   = "owned"
  }
}

# private subnet for the ec2 instances
resource "aws_subnet" "private_subnet" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = "11.0.1.0/24"
  availability_zone       = "eu-west-1a"
  map_public_ip_on_launch = true
  tags = {
    "Name"                            = "private-eu-west-1a"
    "kubernetes.io/role/internal-elb" = "1"
    "kubernetes.io/cluster/chatbot"   = "owned"
  }
}

# gateway to connect to outside world
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

}

# eip provides a stable public ip to nat_gateway
resource "aws_eip" "nat" {
  depends_on = [aws_internet_gateway.igw]
}

# provides a gateway for private subnet resources to connect to public subnet resources(alb)
resource "aws_nat_gateway" "nat_gw" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public_subnet.id
}

# route table to route aws public subnet resources to outside world using internet gateway
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id

  }
  tags = {
    Name = "public"
  }
}

# route table to route aws private subnet resources to outside world using nat gateway
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat_gw.id

  }
  tags = {
    Name = "private"
  }
}

resource "aws_route_table_association" "public_rta" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "private_rta" {
  subnet_id      = aws_subnet.private_subnet.id
  route_table_id = aws_route_table.private.id
}