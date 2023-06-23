provider "aws" {
  region = var.region
}


resource "aws_vpc" "vpc_practica_6" {
  cidr_block = var.cidr_vpc
}


resource "aws_subnet" "subnet_public" {
  vpc_id                  = aws_vpc.vpc_practica_6.id
  cidr_block              = var.cidr_subnet
  map_public_ip_on_launch = true
}


resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.vpc_practica_6.id
}


resource "aws_route_table" "route_tab" {
  vpc_id = aws_vpc.vpc_practica_6.id

  route {
    cidr_block = var.cidr_def
    gateway_id = aws_internet_gateway.gw.id
  }
}


resource "aws_route_table_association" "route_tab_assoc" {
  subnet_id      = aws_subnet.subnet_public.id
  route_table_id = aws_route_table.route_tab.id
}


resource "aws_instance" "instancia" {
  ami                    = var.instance.ami
  subnet_id              = aws_subnet.subnet_public.id
  instance_type          = var.instance.instance_type
  vpc_security_group_ids = [aws_security_group.security_group_practica_6.id]
  key_name               = "keys_work"
  user_data              = file("script.sh")


  # user_data = <<-EOF
  #   #!/bin/bash
  #   hostnamectl set-hostname aws-${each.key}
  #   EOF
}


resource "aws_security_group" "security_group_practica_6" {
  name        = "security group practica_6"
  description = "Permitir trafico entrante SSH y saliente a todo"
  vpc_id      = aws_vpc.vpc_practica_6.id

  ingress {
    description = "Acceso por puerto 22 (SSH)"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.cidr_def]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = [var.cidr_def]
    ipv6_cidr_blocks = ["::/0"]
  }
}