# VPC

resource "aws_vpc" "main" {

  cidr_block = "10.0.0.0/16"

  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "b-alb-vpc"
  }
}


# Internet Gateway

resource "aws_internet_gateway" "igw" {

  vpc_id = aws_vpc.main.id

  tags = {
    Name = "b-alb-igw"
  }
}


# Public Subnet 1

resource "aws_subnet" "public_1" {

  vpc_id = aws_vpc.main.id

  cidr_block = "10.0.1.0/24"

  availability_zone = "us-east-1a"

  map_public_ip_on_launch = true

  tags = {
    Name = "b-public-subnet-1"
  }
}


# Public Subnet 2

resource "aws_subnet" "public_2" {

  vpc_id = aws_vpc.main.id

  cidr_block = "10.0.2.0/24"

  availability_zone = "us-east-1b"

  map_public_ip_on_launch = true

  tags = {
    Name = "b-public-subnet-2"
  }
}

# Public Route Table

resource "aws_route_table" "public" {

  vpc_id = aws_vpc.main.id

  route {

    cidr_block = "0.0.0.0/0"

    gateway_id = aws_internet_gateway.igw.id
  }


  tags = {
    Name = "b-public-route-table"
  }
}


# Route Table Association Subnet 1

resource "aws_route_table_association" "public_1" {

  subnet_id = aws_subnet.public_1.id

  route_table_id = aws_route_table.public.id
}



# Route Table Association Subnet 2

resource "aws_route_table_association" "public_2" {

  subnet_id = aws_subnet.public_2.id

  route_table_id = aws_route_table.public.id
}

# ALB Security Group

resource "aws_security_group" "alb_sg" {

  name = "b-alb-security-group"

  vpc_id = aws_vpc.main.id


  # Allow HTTP Traffic

  ingress {

    from_port = 80

    to_port = 80

    protocol = "tcp"

    cidr_blocks = ["0.0.0.0/0"]
  }


  # Allow HTTPS Traffic

  ingress {

    from_port = 443

    to_port = 443

    protocol = "tcp"

    cidr_blocks = ["0.0.0.0/0"]
  }


  # Allow All Outbound Traffic

  egress {

    from_port = 0

    to_port = 0

    protocol = "-1"

    cidr_blocks = ["0.0.0.0/0"]
  }


  tags = {

    Name = "b-alb-sg"

  }
}

# Application Load Balancer

resource "aws_lb" "application" {

  name = var.alb_name

  load_balancer_type = "application"

  internal = false

  security_groups = [
    aws_security_group.alb_sg.id
  ]

  subnets = [
    aws_subnet.public_1.id,
    aws_subnet.public_2.id
  ]


  tags = {
    Name = var.alb_name
  }
}

# Target Group

resource "aws_lb_target_group" "app" {

  name = "b-alb-target-group"

  port = 80

  protocol = "HTTP"

  vpc_id = aws_vpc.main.id


  health_check {

    path = "/"

    port = "80"

    protocol = "HTTP"

    healthy_threshold = 3

    unhealthy_threshold = 3

    timeout = 5

    interval = 30
  }


  tags = {
    Name = "b-target-group"
  }
}



# ALB Listener

resource "aws_lb_listener" "http" {

  load_balancer_arn = aws_lb.application.arn

  port = 80

  protocol = "HTTP"


  default_action {

    type = "forward"

    target_group_arn = aws_lb_target_group.app.arn
  }
}