resource "aws_instance" "jenkins_master" {
  ami                    = "ami-096a4fdbcf530d8e0" # Amazon Linux (проверь регион!)
  instance_type          = "t3.micro"
  subnet_id              = aws_subnet.public.id
  key_name               = aws_key_pair.jenkins_key.key_name
  vpc_security_group_ids = [aws_security_group.jenkins_sg.id]

  associate_public_ip_address = true

  tags = {
    Name = "jenkins-master"
  }
}

resource "aws_spot_instance_request" "jenkins_worker" {
  ami           = "ami-096a4fdbcf530d8e0"
  instance_type = "t3.micro"

  root_block_device {
    volume_size = 20
    volume_type = "gp2"
  }

  subnet_id              = aws_subnet.private.id
  key_name               = aws_key_pair.jenkins_key.key_name
  vpc_security_group_ids = [aws_security_group.jenkins_sg.id]

  tags = {
    Name = "jenkins-worker"
  }
}

