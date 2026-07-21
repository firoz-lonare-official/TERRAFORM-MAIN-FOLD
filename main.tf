resource "aws_instance" "example" {
  ami           = "ami-06067086cf86c58e6"
  instance_type = "t3.micro"

  tags = {
    Name = "HelloWorld"
  }
}