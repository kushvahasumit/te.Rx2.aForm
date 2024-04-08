terraform {
  backend "s3" {
    bucket = "terraform-s3-rds"
    key = "mysql/terraform.tfstate"
    region = "ap-south-1"
  }
}