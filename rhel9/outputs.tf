output "ipv4_publica" {
  value = "La ipv4 pública de esta instancia es: ${aws_instance.rhel9.public_ip}"
}

output "dns_publica" {
  value = "La dns pública de esta instancia es: ${aws_instance.rhel9.public_dns}"
}
