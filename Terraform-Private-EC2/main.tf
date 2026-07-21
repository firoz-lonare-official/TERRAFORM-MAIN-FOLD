terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

#################################################
# VPC
#################################################

resource "aws_vpc" "main" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "f-vpc"
  }
}

#################################################
# Public Subnet
#################################################

resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "f-public-subnet"
  }
}

#################################################
# Private Subnet 1
#################################################

resource "aws_subnet" "private" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "f-private-subnet-1"
  }
}

#################################################
# Private Subnet 2
#################################################

resource "aws_subnet" "private2" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.3.0/24"
  availability_zone = "us-east-1b"

  tags = {
    Name = "f-private-subnet-2"
  }
}

#################################################
# Internet Gateway
#################################################

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "f-igw"
  }
}

#################################################
# Elastic IP
#################################################

resource "aws_eip" "nat" {
  domain = "vpc"

  tags = {
    Name = "f-eip"
  }
}

#################################################
# NAT Gateway
#################################################

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public.id

  depends_on = [
    aws_internet_gateway.igw
  ]

  tags = {
    Name = "f-nat-gateway"
  }
}

#################################################
# Public Route Table
#################################################

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "f-public-rt"
  }
}

#################################################
# Private Route Table
#################################################

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat.id
  }

  tags = {
    Name = "f-private-rt"
  }
}

#################################################
# Route Table Associations
#################################################

resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "private1" {
  subnet_id      = aws_subnet.private.id
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "private2" {
  subnet_id      = aws_subnet.private2.id
  route_table_id = aws_route_table.private.id
}

#################################################
# Security Group - EC2
#################################################

resource "aws_security_group" "private_sg" {
  name        = "f-private-sg"
  description = "Private EC2 SG"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "SSH from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
  }

  ingress {
    description = "HTTP from VPC"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "f-private-sg"
  }
}

#################################################
# Private EC2
#################################################

resource "aws_instance" "private_ec2" {
  ami           = "ami-01edba92f9036f76e"
  instance_type = "t3.micro"

  subnet_id = aws_subnet.private.id

  vpc_security_group_ids = [
    aws_security_group.private_sg.id
  ]

  associate_public_ip_address = false

  # Uncomment after creating a Key Pair in AWS
  # key_name = "your-keypair"

  tags = {
    Name = "f-private-ec2"
  }
}

#################################################
# DB Subnet Group
#################################################

resource "aws_db_subnet_group" "db_subnet" {
  name = "f-db-subnet-group"

  subnet_ids = [
    aws_subnet.private.id,
    aws_subnet.private2.id
  ]

  tags = {
    Name = "f-db-subnet-group"
  }
}

#################################################
# Security Group - RDS
#################################################

resource "aws_security_group" "rds_sg" {
  name   = "f-rds-sg"
  vpc_id = aws_vpc.main.id

  ingress {
    description = "MySQL from EC2"
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"

    security_groups = [
      aws_security_group.private_sg.id
    ]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "f-rds-sg"
  }
}

#################################################
# RDS MySQL
#################################################

resource "aws_db_instance" "mysql" {

  identifier = "f-mysql-db"

  allocated_storage = 20

  engine = "mysql"

  engine_version = "8.0"

  instance_class = "db.t3.micro"

  db_name = "mydb"

  username = "admin"

  password = "Firoz12345"

  db_subnet_group_name = aws_db_subnet_group.db_subnet.name

  vpc_security_group_ids = [
    aws_security_group.rds_sg.id
  ]

  publicly_accessible = false

  skip_final_snapshot = true

  tags = {
    Name = "f-rds"
  }
}