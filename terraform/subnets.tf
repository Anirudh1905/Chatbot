# public subnet 1 for the alb
resource "aws_subnet" "public-us-east-1a" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = "12.0.0.0/19"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true
  tags = {
    "Name"                                  = "public-us-east-1a"
    "kubernetes.io/role/elb"                = "1"
    "kubernetes.io/cluster/chatbot-cluster" = "owned"
  }
}

# public subnet 2 for the alb
resource "aws_subnet" "public-us-east-1b" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = "12.0.32.0/19"
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = true
  tags = {
    "Name"                                  = "public-us-east-1b"
    "kubernetes.io/role/elb"                = "1"
    "kubernetes.io/cluster/chatbot-cluster" = "owned"
  }
}

# private subnet 1 for the ec2 instances
resource "aws_subnet" "private-us-east-1a" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = "12.0.64.0/19"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true
  tags = {
    "Name"                                  = "private-us-east-1b"
    "kubernetes.io/role/internal-elb"       = "1"
    "kubernetes.io/cluster/chatbot-cluster" = "owned"
  }
}

# private subnet 2 for the ec2 instances
resource "aws_subnet" "private-us-east-1b" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = "12.0.96.0/19"
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = true
  tags = {
    "Name"                                  = "private-us-east-1a"
    "kubernetes.io/role/internal-elb"       = "1"
    "kubernetes.io/cluster/chatbot-cluster" = "owned"
  }
}