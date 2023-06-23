output "ip_publica" {
  description = "IP_Publica"
  value       = aws_instance.instancia.public_ip
}