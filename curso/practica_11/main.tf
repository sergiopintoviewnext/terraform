provider "aws" {
  region = "eu-west-3"
}

resource "aws_instance" "instancia" {
  ami           = var.description.ami
  instance_type = var.description.type
  tags = {
    Name = "${var.description.project}-${local.sufijo}"
  }

}