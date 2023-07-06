output "ip_publica" {
  value = aws_instance.rhel9.public_ip
}

output "dns_publica" {
  value = aws_instance.rhel9.public_dns
}
