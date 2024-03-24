# Provider Block: Specifies the AWS provider and the region where resources will be provisioned.
provider "aws" {
  region = "ap-south-1"
}

# AWS S3 Bucket Resource: Defines the creation of an AWS S3 bucket.
resource "aws_s3_bucket" "terraform_s3" {
  # Bucket Name: Specifies the name of the S3 bucket using the value of the "bucket_name" variable.
  bucket = "${var.bucket_name}"

  # Bucket Lifecycle Configuration: Defines the lifecycle configuration for the S3 bucket.
  lifecycle {
    # Prevent Destroy: Specifies whether the bucket should be prevented from being destroyed.
    prevent_destroy = false  # Set to true to prevent accidental deletion, false allows destruction.
  }
}

# AWS S3 Bucket Versioning Resource: Configures versioning for the S3 bucket.
resource "aws_s3_bucket_versioning" "example" {
  # Bucket ID: Specifies the ID of the S3 bucket to which versioning should be applied.
  bucket = aws_s3_bucket.terraform_s3.id

  # Versioning Configuration: Specifies the status of versioning for the bucket.
  versioning_configuration {
    # Status: Sets the status of versioning to "Enabled".
    status = "Enabled"
  }
}
