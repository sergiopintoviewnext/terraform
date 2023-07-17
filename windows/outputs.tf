output "ip_publica" {
  value = aws_instance.windows.public_ip
}

output "dns_publica" {
  value = aws_instance.windows.public_dns
}
