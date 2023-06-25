provider "aws" {
  region = "eu-west-3"
}

resource "aws_instance" "instancia_condicional" {
  count = var.condicion_booleana ? 1 : 0
  #count = var.condicion_number == 1 ? 1 : 0  # < > == <= >= !=
  #count = var.condicion_number != 1 ? var.condicion_number : 0 


  ami           = "ami-05b5a865c3579bbc4"
  instance_type = "t2.micro"
}
