# Variable Block: Defines a variable named "bucket_name" that represents the name of the S3 bucket.
variable "bucket_name" {
  # Description: Provides a description of the variable.
  description = "This is the name of the S3 bucket that must be globally unique and in lowercase."
  
  # Default Value: Specifies the default value of the variable.
  default = "terraform-mybucket-for-practice"
}
