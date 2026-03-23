output "jenkins_master_ip" {
  value = aws_instance.jenkins_master.public_ip
}

output "worker_private_ip" {
  value = aws_spot_instance_request.jenkins_worker.private_ip
}

