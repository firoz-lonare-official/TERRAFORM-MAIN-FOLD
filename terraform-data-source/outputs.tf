output "instance_id" {
  value = aws_instance.server.id
}

output "instance_public_ip" {
  value = aws_instance.server.public_ip
}

output "ami_id" {
  value = data.aws_ami.amazon_linux.id
}

output "vpc_id" {
  value = data.aws_vpc.existing.id
}

