output "public_ip" {
  description = "The public IP address for web access"
  value       = module.sg_nginx.public_ip

}
