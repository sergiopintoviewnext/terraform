provider "aws" {
  region = var.region
}


data "aws_vpc" "default" {
  default = true
}


resource "aws_instance" "windows" {
  ami                    = var.instance_espects.ami
  instance_type          = var.instance_espects.type
  key_name               = "mi_primer_servidor_keys" //nombre clave ssh
  vpc_security_group_ids = [aws_security_group.mi_grupo_de_seguridad.id]

  connection {
    type            = "ssh"
    user            = var.user_data.user_name
    password        = var.user_data.password
    host            = self.public_ip
    timeout         = "5m"
    target_platform = "windows"
  }

  provisioner "file" {
    source      = "script.ps1"
    destination = "C:/script.ps1"
  }

  provisioner "remote-exec" {
    inline = [
      "powershell.exe -ExecutionPolicy Bypass -File C:/script.ps1"
    ]
  }

  user_data = <<-EOF
    <powershell>
    net user ${var.user_data.user_name} ${var.user_data.password}
    Add-WindowsCapability -Online -Name OpenSSH.Server~~~~0.0.1.0
    Start-Service sshd
    Set-Service -Name sshd -StartupType 'Automatic'
    Set-Service -Name ssh-agent -StartupType 'Automatic'
    </powershell>
    EOF

  tags = {
    Name = "servidor-windows_2022"
  }

}


resource "aws_security_group" "mi_grupo_de_seguridad" {

  name = "sg_windows"

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