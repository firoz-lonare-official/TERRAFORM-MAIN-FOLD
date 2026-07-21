output "rds_id" {
  value = module.rds.db_id
}


output "rds_endpoint" {
  value = module.rds.db_endpoint
}


output "vpc_id" {
  value = aws_vpc.main.id
}