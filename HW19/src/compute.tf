
data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "public" {
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = "t3.micro"
  subnet_id                   = aws_subnet.public.id
  associate_public_ip_address = true
  key_name                    = "cds"
  vpc_security_group_ids      = [
    aws_security_group.public_sg.id
  ]

  tags = {
    Name = "che-Public"
  }
}

resource "aws_instance" "private" {
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = "t3.micro"
  associate_public_ip_address = false
  subnet_id                   = aws_subnet.private.id
  key_name                    = "cds"
  vpc_security_group_ids      = [
    aws_security_group.private_sg.id
  ]

  tags = {
    Name = "che-Privat"
  }
}

output "public_ip" {
  value = aws_instance.public.public_ip
}

output "private_ip" {
  value = aws_instance.private.private_ip
}
