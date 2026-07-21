# VPC

resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "b-rds-vpc"
  }
}


# Private Subnet 1

resource "aws_subnet" "private_1" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "b-private-subnet-1"
  }
}


# Private Subnet 2

resource "aws_subnet" "private_2" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "us-east-1b"

  tags = {
    Name = "b-private-subnet-2"
  }
}


# RDS Module

module "rds" {

  source = "./modules/rds"

  db_identifier     = var.db_identifier
  db_name           = var.db_name
  db_username       = var.db_username
  db_password       = var.db_password
  db_instance_class = var.db_instance_class

  private_subnet_ids = [
    aws_subnet.private_1.id,
    aws_subnet.private_2.id
  ]
}