resource "aws_instance" "server" {
  ami                         = "ami-01edba92f9036f76e"
  instance_type               = "t3.micro"

  subnet_id                   = "subnet-0e5442ae27f9fcb72"
  vpc_security_group_ids      = ["sg-05f87e750d708cd11"]
  associate_public_ip_address = true

  tags = {
    Name = "Terraform-Lifecycle"
  }

  lifecycle {
    create_before_destroy = true
    prevent_destroy       = false

    ignore_changes = [
      tags
    ]
  }
}