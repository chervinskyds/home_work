provider "aws" {
  region = "eu-central-1"
}

module "nginx_instance" {
  source             = "./modules/nginx_instance"
  vpc_id             = aws_vpc.hw20.id
  subnet_id          = aws_subnet.public.id
  list_of_open_ports = [22, 80, 443]
}