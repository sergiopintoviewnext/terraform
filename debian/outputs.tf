output "ip_publica" {
  value = aws_instance.debian.public_ip
}

output "dns_publica" {
  value = aws_instance.debian.public_dns
}
