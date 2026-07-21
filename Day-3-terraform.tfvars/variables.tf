variable "aws_region" {
  type    = string
  default = "us-east-1"
}

variable "ami_id" {
  type = string
}

variable "instance_type" {
  type    = string
  default = "t3.micro"
}

variable "instance_name" {
  type    = string
  default = "firoz-instance"
}

variable "vpc_cidr" {
  type    = string
  default = "10.0.0.0/16"
}

variable "subnet_cidr" {
  type    = string
  default = "10.0.1.0/24"
}

variable "availability_zone" {
  type    = string
  default = "us-east-1a"
}

variable "route_cidr" {
  type    = string
  default = "0.0.0.0/0"
}

variable "ingress_cidr" {
  type    = string
  default = "0.0.0.0/0"
}

variable "egress_cidr" {
  type    = string
  default = "0.0.0.0/0"
}

variable "vpc_name" {
  type    = string
  default = "terraform-vpc"
}

variable "subnet_name" {
  type    = string
  default = "terraform-subnet"
}

variable "igw_name" {
  type    = string
  default = "terraform-igw"
}

variable "security_group_name" {
  type    = string
  default = "terraform-sg"
}