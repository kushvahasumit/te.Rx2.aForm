provider "aws" {
  region = "ap-south-1"
}

resource "aws_security_group" "server" {
  name = "terraform_server"

# This security group configuration allows incoming TCP traffic on port 8080 from any IPv4 address. 
  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  
  }
}

resource "aws_instance" "example" {
  ami = "ami-007020fd9c84e18c7"
  instance_type = "t2.micro"
  vpc_security_group_ids = ["${aws_security_group.server.id}"]

  user_data = <<-EOF
              #!/bin/bash
              echo "Hello, World!" > index.html
              nohup busybox httpd -f -p 8080 &
              EOF

  tags = {
    name = "terraform-server-example"
  }
}

