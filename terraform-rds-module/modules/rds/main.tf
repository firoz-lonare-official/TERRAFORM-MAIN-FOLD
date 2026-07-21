resource "aws_db_subnet_group" "mysql" {

  name = "${var.db_identifier}-subnet-group"

  subnet_ids = var.private_subnet_ids

  tags = {
    Name = "${var.db_identifier}-subnet-group"
  }
}



resource "aws_db_instance" "mysql" {

  identifier = var.db_identifier

  engine         = "mysql"
  engine_version = "8.0"

  instance_class = var.db_instance_class

  allocated_storage = 20
  storage_type      = "gp3"

  db_name  = var.db_name
  username = var.db_username
  password = var.db_password


  db_subnet_group_name = aws_db_subnet_group.mysql.name


  publicly_accessible = false

  skip_final_snapshot = true


  tags = {
    Name = var.db_identifier
  }
}