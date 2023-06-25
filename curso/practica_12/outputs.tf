output "ip_publica" {
  description = "IP publica de instancia"
  value       = { for instance_key, instance in aws_instance.instancia_practica : instance_key => instance.public_ip }
}

output "ip_privada" {
  description = "IP privada de instancia"
  value       = { for instance_key, instance in aws_instance.instancia_practica : instance_key => instance.private_ip }
}

output "dns_publica" {
  description = "DNS publica de instancia"
  value       = { for instance_key, instance in aws_instance.instancia_practica : instance_key => instance.public_dns }
}

output "dns_privada" {
  description = "DNS privada de instancia"
  value       = { for instance_key, instance in aws_instance.instancia_practica : instance_key => instance.private_dns }
}