resource "aws_security_group" "sg_practica" {
  name        = "sg_practica"
  description = "Security group de practica ${var.numero_practica}"
  vpc_id      = var.vpc_id

  tags = {
    Name = "sg_practica_${var.numero_practica}"
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

  ingress {
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Permitir ICMP"
  }

  egress {
    description = "Permitir salida a internet"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.cidr.internet]
  }
}