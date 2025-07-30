resource "aws_instance" "jenkins_master" {
  ami                    = "ami-0df0e7600ad0913a9"
  instance_type          = "t3.micro"
  subnet_id              = aws_subnet.public.id
  key_name               = "cds"
  vpc_security_group_ids = [aws_security_group.jenkins_sg.id]
  user_data              = file("scripts/master.sh")
  tags = {
    Name = "jenkins-master"
  }
}

resource "aws_instance" "jenkins_worker" {
  ami                    = "ami-0df0e7600ad0913a9"
  instance_type          = "t3.micro"
  subnet_id              = aws_subnet.private.id
  key_name               = "cds"
  vpc_security_group_ids = [aws_security_group.jenkins_sg.id]

  instance_market_options {
    market_type = "spot"
  }

  user_data = file("scripts/worker.sh")

  tags = {
    Name = "jenkins-worker"
  }
}
