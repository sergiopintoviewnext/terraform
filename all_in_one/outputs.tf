output "ipv4_publica" {
  value = { for instance_key, instance in aws_instance.instancia : instance_key => instance.public_ip }
}

output "dns_publica" {
  value = { for instance_key, instance in aws_instance.instancia : instance_key => instance.public_dns }
}
