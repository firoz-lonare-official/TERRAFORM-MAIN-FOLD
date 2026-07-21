output "db_id" {
  value = aws_db_instance.mysql.id
}


output "db_endpoint" {
  value = aws_db_instance.mysql.endpoint
}