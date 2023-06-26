

output "ip_publica" {
  description = "IP publica de instancia"
  value       = module.instance.ip_publica
}

output "ip_privada" {
  description = "IP privada de instancia"
  value       = module.instance.ip_privada
}

output "dns_publica" {
  description = "DNS publica de instancia"
  value       = module.instance.dns_publica
}

output "dns_privada" {
  description = "DNS privada de instancia"
  value       = module.instance.dns_privada
}