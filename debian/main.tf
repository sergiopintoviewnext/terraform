provider "aws" {
  region = "eu-west-3"
}


data "aws_vpc" "default" {
  default = true
}



resource "aws_instance" "debian" {
  ami                    = "ami-0eeeb6788f77d3616"
  instance_type          = "t2.micro"
  key_name               = "keys" //nombre clave ssh
  vpc_security_group_ids = [aws_security_group.mi_grupo_de_seguridad.id]

  tags = {
    Name = "servidor-debian_11"
  }

}


resource "aws_security_group" "mi_grupo_de_seguridad" {
  name = "debian"


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
