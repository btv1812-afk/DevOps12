provider "aws" {
  region = var.vpc_region
    
}
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }

  required_version = ">=1.2"
}
    
resource "aws_vpc" "main" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "my-vpc"

  }
}

# --------------------------
# Public Subnet
# --------------------------

resource "aws_subnet" "public" {
  cidr_block       = var.public_subnet_cidr
  vpc_id = aws_vpc.main.id
  map_public_ip_on_launch = true

  tags = {
    Name = "public-subnet"
  }
}

# --------------------------
# Private Subnet
# --------------------------

resource "aws_subnet" "private" {
  cidr_block       = var.private_subnet_cidr
  vpc_id = aws_vpc.main.id


  tags = {
    Name = "private-subnet" 
  }   
}

# --------------------------
# Internet Gateway for Public Subnet
# --------------------------

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "gateway"
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id
}

resource "aws_route" "public_internet" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.gw.id

}

resource "aws_route_table_association" "public_assoc" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}

# --------------------------
# NAT Gateway for Private Subnet
# --------------------------

resource "aws_eip" "nat" {
  domain = "vpc"
}

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public.id
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id
}

resource "aws_route" "private_nat" {
  route_table_id         = aws_route_table.private.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat.id
}

resource "aws_route_table_association" "private_assoc" {
  subnet_id      = aws_subnet.private.id
  route_table_id = aws_route_table.private.id
}