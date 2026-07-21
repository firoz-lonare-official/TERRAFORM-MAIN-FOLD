resource "aws_instance" "server" {
  ami                         = data.aws_ami.amazon_linux.id
  instance_type               = "t3.micro"
  subnet_id                   = data.aws_subnets.public.ids[0]
  vpc_security_group_ids      = [data.aws_security_group.default.id]
  associate_public_ip_address = true

  tags = {
    Name = "Terraform-DataSource-EC2"
  }
}