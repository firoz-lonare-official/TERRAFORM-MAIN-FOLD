output "instance_ids" {
  value = aws_instance.name[*].id
}

output "public_ips" {
  value = aws_instance.name[*].public_ip
}

output "private_ips" {
  value = aws_instance.name[*].private_ip
}

output "vpc_id" {
  value = aws_vpc.main.id
}