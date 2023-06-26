data "aws_key_pair" "key" {
  key_name = "keys_work"
}

resource "aws_instance" "instancia_practica" {
  for_each = var.ami

  ami                         = each.value
  instance_type               = var.instance_type
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = [var.sg_id]
  associate_public_ip_address = true
  key_name                    = data.aws_key_pair.key.key_name
  user_data                   = <<-EOF
    hostnamectl set-hostname ${each.key}-server-aws
  EOF

  tags = {
    Name = each.key
  }

}