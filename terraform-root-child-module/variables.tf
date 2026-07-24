variable "aws_region" {
  description = "AWS Region"
  type        = string
}

variable "vpc_cidr" {
  description = "VPC CIDR Block"
  type        = string
}

variable "public_subnet_cidr" {
  description = "Public Subnet CIDR Block"
  type        = string
}

variable "ami_id" {
  description = "EC2 AMI ID"
  type        = string
}

variable "instance_type" {
  description = "EC2 Instance Type"
  type        = string
}