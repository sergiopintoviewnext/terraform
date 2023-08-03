output "ip_publica" {
  value = aws_instance.rhel.public_ip
}

output "dns_publica" {
  value = aws_instance.rhel.public_dns
}
