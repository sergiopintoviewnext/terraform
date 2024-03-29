provider "aws" {
  region = var.region
}

resource "aws_instance" "instancia" {
  for_each = var.instance_amis

  ami                    = each.value
  instance_type          = var.instance_type
  key_name               = "mi_primer_servidor_keys" //nombre clave ssh
  vpc_security_group_ids = [aws_security_group.mi_grupo_de_seguridad.id]

  root_block_device {
    volume_size = var.volume_size
  }

  user_data = <<-EOF
    #!/bin/bash
    hostnamectl set-hostname aws-${each.key}
    EOF

  tags = {
    Name = each.key
  }
}

resource "aws_security_group" "mi_grupo_de_seguridad" {

  name = "grupo_seguridad"

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

}
