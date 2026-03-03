output "public_ip" {
    description = "The public IP address for web access"
    value = aws_instance.nginx_instance.public_ip

}
