output "api_instance_ip" {
  description = "Public IP of API server"
  value       = aws_instance.api_vm.public_ip
}

output "training_instance_ip" {
  description = "Public IP of Training server"
  value       = aws_instance.training_vm.public_ip
}