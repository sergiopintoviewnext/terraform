resource "aws_vpc" "vpc_practica" {
  cidr_block = var.cidr.vpc
  tags = {
    Name = "vpc_practica_${local.numero_practica}"
  }
}


resource "aws_subnet" "subnet" {
  vpc_id                  = aws_vpc.vpc_practica.id
  cidr_block              = var.cidr.subnet
  map_public_ip_on_launch = true
  tags = {
    Name = "subnet_practica_${local.numero_practica}"
  }
}


resource "aws_internet_gateway" "gw_practica" {
  vpc_id = aws_vpc.vpc_practica.id
  tags = {
    Name = "gateway_practica_${local.numero_practica}"
  }
}


resource "aws_route_table" "route_table_practica" {
  vpc_id = aws_vpc.vpc_practica.id

  route {
    cidr_block = var.cidr.internet
    gateway_id = aws_internet_gateway.gw_practica.id
  }
  tags = {
    Name = "route_table_practica_${local.numero_practica}"
  }
}


resource "aws_route_table_association" "assoc_route_table" {
  subnet_id      = aws_subnet.subnet.id
  route_table_id = aws_route_table.route_table_practica.id
}