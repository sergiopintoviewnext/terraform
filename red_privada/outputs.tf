output "ip_publica" {
  description = "ip publica de instancia publica"
  value       = aws_instance.instancia_publica.public_ip
}

output "dns_publica" {
  description = "dns publica de instancia publica"
  value       = aws_instance.instancia_publica.public_dns
}

output "ip_privada" {
  description = "ip privada de instancias"
  value       = "instancia publica => ${aws_instance.instancia_publica.private_ip}      instancia privada => ${aws_instance.instancia_priv.private_ip}"
}