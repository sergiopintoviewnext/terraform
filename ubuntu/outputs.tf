output "ip_publica" {
  value = aws_instance.ubuntu.public_ip
}

output "dns_publica" {
  value = aws_instance.ubuntu.public_dns
}
