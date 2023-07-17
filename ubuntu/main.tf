provider "aws" {
  region = var.region
}


data "aws_vpc" "default" {
  default = true
}



resource "aws_instance" "ubuntu" {
  ami                    = var.instance_espects.ami
  instance_type          = var.instance_espects.type
  key_name               = "keys_work" //nombre clave ssh
  vpc_security_group_ids = [aws_security_group.mi_grupo_de_seguridad.id]

  root_block_device {
    volume_size = var.instance_espects.volume_size
  }

  user_data = <<-EOF
    #!/bin/bash
    hostnamectl set-hostname aws-ubuntu
    EOF

  tags = {
    Name = "servidor-ubuntu_22_04"
  }

}


resource "aws_security_group" "mi_grupo_de_seguridad" {

  name = "sg_ubuntu"

  dynamic "ingress" {
    for_each = var.list_ports

    content {
      description = "Permitir trafico ${ingress.key}"
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = [var.cidr]
    }
  }

  egress {
    description = "Permitir salida a internet"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.cidr]
  }

  ingress {
    description = "Permitir ICMP"
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = [var.cidr]
  }
}
