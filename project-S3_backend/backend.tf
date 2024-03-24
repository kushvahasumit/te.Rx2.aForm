# Terraform Backend Configuration: Configures Terraform to use the created S3 bucket as the backend.
terraform {
  # Backend Block: Specifies the backend configuration.
  backend "s3" {
    # Bucket: Specifies the name of the S3 bucket to use as the backend.
    bucket = "terraform-mybucket-for-practice"

    # Key: Specifies the path to the state file within the bucket.
    key    = "terraform.tfstate"

    # Region: Specifies the AWS region where the S3 bucket is located.
    region = "ap-south-1"
  }
}