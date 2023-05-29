provider "aws" {
  region = "eu-west-3"
}


data "aws_vpc" "default" {
  default = true
}



resource "aws_instance" "rhel9" {
  ami = "ami-0d767e966f3458eb5"
  instance_type = "t2.micro"
  key_name      = "keys" //nombre clave ssh
  vpc_security_group_ids = [aws_security_group.mi_grupo_de_seguridad.id]

  tags = {
    Name = "servidor-rhel9"
  }  

}


resource "aws_security_group" "mi_grupo_de_seguridad" {
  name   = "rhel"


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
    from_port   = 3000
    to_port     = 3000
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
