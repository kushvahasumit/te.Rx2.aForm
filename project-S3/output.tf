# Output Block: Defines an output named "bucket_id" that provides information about the S3 bucket.
output "bucket_id" {
  # Value Block: Specifies the value of the output.
  value = {
    # ARN: Specifies the Amazon Resource Name (ARN) of the S3 bucket.
    arn = aws_s3_bucket.terraform_s3.arn
    
    # Versioning Enabled: Indicates whether versioning is enabled for the S3 bucket.
    versioning_enabled = aws_s3_bucket.terraform_s3.versioning[0].enabled
  }
}
