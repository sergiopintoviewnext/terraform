output "ip_publica" {
  description = "IP publica"
  value       = "IP publica: ${aws_instance.instancia.public_ip}"
}