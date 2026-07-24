output "instance_id" {
  description = "EC2 Instance ID"
  value       = aws_instance.server.id
}

output "public_ip" {
  description = "EC2 Public IP"
  value       = aws_instance.server.public_ip
}