output "vpc_id" {
  value = aws_vpc.hw20.id
}

output "subnet_id" {
  value = aws_subnet.public.id
}

output "instance_public_ip" {
  value = module.nginx_instance.instance_public_ip
}