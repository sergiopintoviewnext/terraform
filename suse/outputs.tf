output "ip_publica" {
  value = aws_instance.suse.public_ip
}

output "dns_publica" {
  value = aws_instance.suse.public_dns
}
