provider "aws" {
  region = "eu-central-1"
}
resource "aws_key_pair" "deployer" {
  key_name   = "deployer-key"
  public_key = file("hw21.pub")
}

resource "aws_security_group" "web_sg" {
  name = "web-sg"

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP"
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
  count = 2

  ami           = "ami-0faab6bdbac9486fb"
  instance_type = "t3.micro"
  key_name      = aws_key_pair.deployer.key_name

  vpc_security_group_ids = [aws_security_group.web_sg.id]
  
  associate_public_ip_address = true

  tags = {
    Name = "ansible-server-${count.index}"

    
  }
}

resource "local_file" "inventory" {

  content = templatefile("${path.module}/inventory.tpl", {
    ips = aws_instance.web[*].public_ip
  })

  filename = "${path.module}/ansible/inventory.ini"
}

