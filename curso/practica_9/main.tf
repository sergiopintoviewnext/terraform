provider "aws" {
  region = var.region_aws
}


resource "aws_vpc" "vpc_practica_9" {
  cidr_block = var.cidr.vpc
  tags = {
    Name = "vpc_practica_9"
  }
}


resource "aws_subnet" "subnet" {
  vpc_id                  = aws_vpc.vpc_practica_9.id
  cidr_block              = var.cidr.subnet
  map_public_ip_on_launch = true
}


resource "aws_internet_gateway" "gw_practica_9" {
  vpc_id = aws_vpc.vpc_practica_9.id
}


resource "aws_route_table" "route_table_practica_9" {
  vpc_id = aws_vpc.vpc_practica_9.id

  route {
    cidr_block = var.cidr.internet
    gateway_id = aws_internet_gateway.gw_practica_9.id
  }
}


resource "aws_route_table_association" "assoc_route_table" {
  subnet_id      = aws_subnet.subnet.id
  route_table_id = aws_route_table.route_table_practica_9.id
}


data "aws_key_pair" "key" {
  key_name = "mi_primer_servidor_keys"
}

resource "aws_instance" "instancia_practica_9" {
  for_each = var.ami

  ami                         = each.value
  instance_type               = var.instance_type
  subnet_id                   = aws_subnet.subnet.id
  vpc_security_group_ids      = [aws_security_group.sg_practica_9.id]
  associate_public_ip_address = true
  key_name                    = data.aws_key_pair.key.key_name
  user_data                   = <<-EOF
    hostnamectl set-hostname ${each.key}-server-aws
  EOF

  tags = {
    Name = each.key
  }

}


resource "aws_security_group" "sg_practica_9" {
  name        = "sg_practica_9"
  description = "Security group de practica 9"
  vpc_id      = aws_vpc.vpc_practica_9.id

  # ingress {
  #   description = "Permitir conexion SSH"
  #   from_port   = 22
  #   to_port     = 22
  #   protocol    = "tcp"
  #   cidr_blocks = [var.cidr.internet]
  # }

  ingress {
    description = "Permitir todo"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.cidr.internet]
  }

  egress {
    description = "Permitir salida a internet"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.cidr.internet]
  }
}