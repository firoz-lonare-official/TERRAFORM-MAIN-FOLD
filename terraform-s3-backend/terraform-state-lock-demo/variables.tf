variable "aws_region" {
  description = "AWS Region"
  type        = string
  default     = "us-east-1"
}

variable "instance_type" {
  description = "EC2 Instance Type"
  type        = string
  default     = "t3.micro"
}

variable "instance_name" {
  description = "EC2 Name"
  type        = string
  default     = "Terraform-Server"
}

variable "bucket_name" {
  description = "S3 Bucket Name"
  type        = string
}

variable "dynamodb_table" {
  description = "DynamoDB Table Name"
  type        = string
}