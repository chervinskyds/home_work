resource "aws_security_group" "public_sg" {

  name = "public-sg"

  description = "Allow SSH/HTTP from anywhere"

  vpc_id = aws_vpc.main.id



  ingress {

    description = "SSH"

    from_port = 22

    to_port = 22

    protocol = "tcp"

    cidr_blocks = ["0.0.0.0/0"]

  }

  ingress {

    description = "HTTP"

    from_port = 80

    to_port = 80

    protocol = "tcp"

    cidr_blocks = ["0.0.0.0/0"]

  }

  egress {

    from_port = 0

    to_port = 0

    protocol = "-1"

    cidr_blocks = ["0.0.0.0/0"]

  }

}

resource "aws_security_group" "private_sg" {

  name = "che-private-sg"

  description = "Allow SSH from public instance only"

  vpc_id = aws_vpc.main.id

  ingress {

    from_port = -1

    to_port = -1

    protocol = "icmp"

    cidr_blocks = ["0.0.0.0/0"]

  }

  ingress {

    from_port = 22

    to_port = 22

    protocol = "tcp"

    security_groups = [aws_security_group.public_sg.id]

  }

  egress {

    from_port = 0

    to_port = 0

    protocol = "-1"

    cidr_blocks = ["0.0.0.0/0"]

  }

}
