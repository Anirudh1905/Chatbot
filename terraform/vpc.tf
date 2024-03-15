resource "aws_vpc" "vpc" {
  cidr_block           = "12.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
}