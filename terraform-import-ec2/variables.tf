variable "aws_region" {
  default = "us-east-1"
}

variable "instance_id" {
  description = "The ID of the EC2 instance to import"
  type        = string
}