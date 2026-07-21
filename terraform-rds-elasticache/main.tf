resource "aws_vpc" "main" {

  cidr_block = var.vpc_cidr

  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "f-vpc"
  }
}


# Private Subnet 1

resource "aws_subnet" "private_1" {

  vpc_id = aws_vpc.main.id

  cidr_block = "10.0.1.0/24"

  availability_zone = "us-east-1a"

  tags = {
    Name = "f-private-subnet-1"
  }
}


# Private Subnet 2

resource "aws_subnet" "private_2" {

  vpc_id = aws_vpc.main.id

  cidr_block = "10.0.2.0/24"

  availability_zone = "us-east-1b"

  tags = {
    Name = "f-private-subnet-2"
  }
}



# Internet Gateway

resource "aws_internet_gateway" "igw" {

  vpc_id = aws_vpc.main.id

  tags = {
    Name = "f-vpc-igw"
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
    Name = "f-public-route-table"
  }
}



# RDS Security Group

resource "aws_security_group" "rds_sg" {

  name = "f-rds-security-group"

  vpc_id = aws_vpc.main.id


  ingress {

    from_port = 3306

    to_port = 3306

    protocol = "tcp"

    cidr_blocks = [
      "10.0.0.0/16"
    ]

  }


  egress {

    from_port = 0

    to_port = 0

    protocol = "-1"

    cidr_blocks = [
      "0.0.0.0/0"
    ]

  }


  tags = {

    Name = "f-rds-sg"

  }

}




# Redis Security Group

resource "aws_security_group" "redis_sg" {

  name = "f-redis-security-group"

  vpc_id = aws_vpc.main.id



  ingress {

    from_port = 6379

    to_port = 6379

    protocol = "tcp"

    cidr_blocks = [
      "10.0.0.0/16"
    ]

  }



  egress {

    from_port = 0

    to_port = 0

    protocol = "-1"

    cidr_blocks = [
      "0.0.0.0/0"
    ]

  }


  tags = {

    Name = "f-redis-sg"

  }

}





# RDS Subnet Group

resource "aws_db_subnet_group" "rds_subnet" {

  name = "f-rds-subnet-group"


  subnet_ids = [

    aws_subnet.private_1.id,

    aws_subnet.private_2.id

  ]


  tags = {

    Name = "f-rds-subnet-group"

  }

}




# RDS MySQL Database

resource "aws_db_instance" "mysql" {


  identifier = "f-mysql-db"


  engine = "mysql"


  engine_version = "8.0"


  instance_class = "db.t3.micro"


  allocated_storage = 20


  username = var.db_username


  password = var.db_password


  db_name = "applicationdb"



  db_subnet_group_name = aws_db_subnet_group.rds_subnet.name



  vpc_security_group_ids = [

    aws_security_group.rds_sg.id

  ]



  publicly_accessible = false



  skip_final_snapshot = true



  tags = {

    Name = "f-rds-mysql"

  }

}

# ElastiCache Redis Subnet Group

resource "aws_elasticache_subnet_group" "redis_subnet" {

  name = "f-redis-subnet-group"


  subnet_ids = [

    aws_subnet.private_1.id,

    aws_subnet.private_2.id

  ]


  tags = {

    Name = "f-redis-subnet-group"

  }

}



# ElastiCache Redis Cluster

resource "aws_elasticache_cluster" "redis" {

  cluster_id = "f-redis-cluster"


  engine = "redis"


  node_type = "cache.t3.micro"


  num_cache_nodes = 1


  parameter_group_name = "default.redis7"


  port = 6379



  subnet_group_name = aws_elasticache_subnet_group.redis_subnet.name



  security_group_ids = [

    aws_security_group.redis_sg.id

  ]



  tags = {

    Name = "f-elasticache-redis"

  }

}