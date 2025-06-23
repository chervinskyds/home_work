output "public_ips" {
  value = aws_instance.web[*].public_ip
}

output "inventory_content" {
  value = templatefile("${path.module}/inventory.tpl", {
    hosts = aws_instance.web[*].public_ip
  })
}
