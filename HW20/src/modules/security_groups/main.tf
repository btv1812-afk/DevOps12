#data "aws_subnet" "public_subnet" {
#  filter {
#   name   = "vpc-id"
 #   values = [var.vpc_id]
 # }

  # Если нужно, можно отфильтровать по тегу, чтобы точно выбрать public subnet
 # filter {
 #   name   = "tag:Name"
#    values = ["public-subnet"]
 # }
# }

terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

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

resource "aws_key_pair" "deployer" {
  key_name   = "deployer-key"
  public_key = "ssh-ed25519 xxx"
}


resource "aws_security_group" "nginx_sg" {
  name        = "nginx_sg"
  description = "Allow TCP traffic to Nginx instance "
  vpc_id      = var.vpc_id


dynamic "ingress" {
 for_each = var.list_of_open_ports

content {
   from_port = ingress.value
   to_port = ingress.value
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

}
  
}


 egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

   tags = {
    Name = "allow_tls"
  }
}



resource "aws_instance" "nginx_instance" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.micro"
  subnet_id = "subnet-0071fe589466da6bd"
  vpc_security_group_ids = [aws_security_group.nginx_sg.id]
  key_name = aws_key_pair.deployer.key_name
  associate_public_ip_address = true

  user_data = <<-EOF
    #!/bin/bash
    set -e

    apt update -y
    apt install -y nginx

    systemctl enable nginx
    systemctl start nginx
  EOF

  tags = {
    Name = "NginxInstance"
  }
}

