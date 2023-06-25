provider "aws" {
  region = var.region_aws
}


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


data "aws_key_pair" "key" {
  key_name = "mi_primer_servidor_keys"
}

resource "aws_instance" "instancia_practica" {
  for_each = var.ami

  ami                         = each.value
  instance_type               = var.instance_type
  subnet_id                   = aws_subnet.subnet.id
  vpc_security_group_ids      = [aws_security_group.sg_practica.id]
  associate_public_ip_address = true
  key_name                    = data.aws_key_pair.key.key_name
  user_data                   = <<-EOF
    hostnamectl set-hostname ${each.key}-server-aws
  EOF

  tags = {
    Name = each.key
  }

}


resource "aws_security_group" "sg_practica" {
  name        = "sg_practica"
  description = "Security group de practica ${local.numero_practica}"
  vpc_id      = aws_vpc.vpc_practica.id

  tags = {
    Name = "sg_practica_${local.numero_practica}"
  }

  dynamic "ingress" {
    for_each = var.list_ports
    content {
      description = "Permitir trafico ${ingress.key}"
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = [var.cidr.internet]
    }
  }

  egress {
    description = "Permitir salida a internet"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.cidr.internet]
  }
}