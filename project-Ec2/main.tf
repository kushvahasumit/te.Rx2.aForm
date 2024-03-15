provider "aws" {
    region = "ap-south-1"
}

resource "aws_instance" "example" {
    ami           = "ami-03bb6d83c60fc5f7c"
    instance_type = "t2.micro"
    subnet_id = "subnet-0c729947d9c83a39e"

    tags = {
    Name = "ExampleInstance"
    Environment = "Production"
  }
}