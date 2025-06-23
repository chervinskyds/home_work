provider "aws" {
  region = "eu-central-1"
}


resource "aws_security_group" "allow_ssh" {
  name_prefix = "hw21-sg"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "web" {
  count         = 2
  ami           = "ami-0df0e7600ad0913a9"
  instance_type = "t2.micro"
  key_name      = "cds"
  security_groups = [aws_security_group.allow_ssh.name]

  tags = {
    Name = "hw21-${count.index}"
  }

  provisioner "local-exec" {
    command = "echo ${self.public_ip} ansible_user=ubuntu >> ../ansible/inventory.ini"
  }
}
