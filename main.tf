provider "aws" {
  region = "eu-west-3"
}


resource "aws_instance" "mi_segundo_servidor" {
  ami             = "ami-0aef57767f5404a3c"
  instance_type   = "t2.micro"
  vpc_security_group_ids = [aws_security_group.mi_grupo_de_seguridad.id]
  user_data = <<-EOF
              #!/bin/bash
              echo "Hola Terraformers" > index.html
              nohup busybox httpd -f -p 8080 &
              EOF
}

resource "aws_security_group" "mi_grupo_de_seguridad" {
  name = "segundo_servidor_sg"

  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    description = "Acceso a puerto 8080 desde el exterior"
    from_port = 8080
    to_port = 8080
    protocol = "TCP"
  }
}



