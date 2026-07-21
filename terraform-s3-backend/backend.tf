terraform {
  backend "s3" {
    bucket = "f-bucket123"
    key    = "dev/terraform.tfstate"
    region = "us-east-1"
  }
}