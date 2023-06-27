provider "aws" {
  region = var.region
}


resource "aws_vpc" "vpc_privada" {
  cidr_block           = var.cidr_subnet
  enable_dns_hostnames = true

  tags = {
    Name = "vpc_privada"
  }
}


resource "aws_subnet" "subnet_privada" {
  vpc_id     = aws_vpc.vpc_privada.id
  cidr_block = var.cidr_subnet

  tags = {
    Name = "subnet_privada"
  }
}


resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.vpc_privada.id

  tags = {
    Name = "gw_privada"
  }
}


resource "aws_route_table" "route_table" {
  vpc_id = aws_vpc.vpc_privada.id

  route {
    cidr_block = var.cidr_internet
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "gw_privada"
  }
}


resource "aws_route_table_association" "assoc_route_table" {
  subnet_id      = aws_subnet.subnet_privada.id
  route_table_id = aws_route_table.route_table.id
}


resource "aws_instance" "instancia_publica" {
  ami                         = var.espects.ami
  instance_type               = var.espects.type
  subnet_id                   = aws_subnet.subnet_privada.id
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.sg_pub.id]
  key_name                    = "keys_work"


  tags = {
    Name = "Servidor_public"
  }
}


resource "aws_instance" "instancia_priv" {
  ami                    = var.espects.ami
  instance_type          = var.espects.type
  subnet_id              = aws_subnet.subnet_privada.id
  vpc_security_group_ids = [aws_security_group.sg_priv.id]
  user_data              = <<-EOF
        #!/bin/bash
        sudo useradd -m -p $(openssl passwd ${var.password}) -s /bin/bash ${var.user}
        sudo sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config
        sudo systemctl restart sshd
  EOF

  tags = {
    Name = "Servidor_priv"
  }
}


resource "aws_security_group" "sg_pub" {

  name   = "sg_pub"
  vpc_id = aws_vpc.vpc_privada.id

  dynamic "ingress" {
    for_each = var.list_ports

    content {
      description = "Permitir trafico ${ingress.key}"
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = [var.cidr_internet]
    }
  }

  egress {
    description = "Permitir salida a internet"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.cidr_internet]
  }

  ingress {
    description = "Permitir ICMP"
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = [var.cidr_internet]
  }
}


resource "aws_security_group" "sg_priv" {

  name   = "sg_priv"
  vpc_id = aws_vpc.vpc_privada.id

  dynamic "ingress" {
    for_each = var.list_ports

    content {
      description = "Permitir trafico ${ingress.key}"
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = [var.cidr_internet]
    }
  }

  egress {
    description = "Permitir salida a internet"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.cidr_internet]
  }

  ingress {
    description = "Permitir ICMP"
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = [var.cidr_internet]
  }
}