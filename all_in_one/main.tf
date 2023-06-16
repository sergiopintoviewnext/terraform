provider "aws" {
  region = var.region
}

resource "aws_instance" "instancia" {
  for_each      = var.instance_amis

  ami           = each.value
  instance_type = var.instance_type
  key_name      = "keys_work" //nombre clave ssh
  vpc_security_group_ids = [aws_security_group.mi_grupo_de_seguridad.id]

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


  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    description = "Acceso al puerto "
    from_port   = 22
    to_port     = 22
    protocol    = "TCP"
  }

  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    description = "Acceso al puerto"
    from_port   = 80
    to_port     = 80
    protocol    = "TCP"
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}