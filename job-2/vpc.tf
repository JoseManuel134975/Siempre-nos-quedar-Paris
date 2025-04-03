provider "aws" {
  region = "us-east-1"  # Cambia a la región que necesites
}

# VPC 2
resource "aws_vpc" "second_vpc" {
  cidr_block = "10.1.0.0/16"  # Cambié el CIDR block para no chocar con la VPC anterior

  tags = {
    Name = "SecondVPC"
  }
}

# Subnet pública en la segunda VPC
resource "aws_subnet" "second_public_subnet" {
  vpc_id                  = aws_vpc.second_vpc.id
  cidr_block              = "10.1.1.0/24"  # Cambié el CIDR block para esta subred
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1b"  # Cambié la zona de disponibilidad

  tags = {
    Name = "SecondPublicSubnet"
  }
}

# Internet Gateway para la segunda VPC
resource "aws_internet_gateway" "second_gw" {
  vpc_id = aws_vpc.second_vpc.id

  tags = {
    Name = "SecondInternetGateway"
  }
}

# Tabla de enrutamiento para la segunda VPC
resource "aws_route_table" "second_public_route" {
  vpc_id = aws_vpc.second_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.second_gw.id
  }

  tags = {
    Name = "SecondPublicRouteTable"
  }
}

# Asociar la subred pública con la tabla de enrutamiento
resource "aws_route_table_association" "second_public_route_association" {
  subnet_id      = aws_subnet.second_public_subnet.id
  route_table_id = aws_route_table.second_public_route.id
}
