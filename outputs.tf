output "instance_ip_addr" {
  value = aws_instance.diffusion_node.public_ip
}

output "instance_dns_name" {
  value = aws_instance.diffusion_node.public_dns
}
