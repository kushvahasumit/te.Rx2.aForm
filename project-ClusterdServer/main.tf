provider "aws" {
  region = "ap-south-1"
}

# it will list all the zones
data "aws_availability_zones" "available" {}

# Security grp for Ec2 instance
resource "aws_security_group" "server" {
  name = "terraform_server_ec2"

# This security group configuration allows incoming TCP traffic on port 8080 from any IPv4 address. 
  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  
  }

  lifecycle {
    create_before_destroy = true
  }
}

# Create a security group for the ELB 
resource "aws_security_group" "elb" {
  name        = "web-server-elb"
  description = "Security group for elb"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Create launch configuraiton
resource "aws_launch_configuration" "example" {
  image_id = "ami-03bb6d83c60fc5f7c"
  instance_type = "t2.micro"
  security_groups = ["${aws_security_group.server.id}"]

  user_data = <<-EOF
              #!/bin/bash
              echo "Hello, World!" > index.html
              nohup busybox httpd -f -p 8080 &
              EOF

  lifecycle{
    create_before_destroy = true
  }

}


# create a autoscaling group
resource "aws_autoscaling_group" "example" {
  launch_configuration = "${aws_launch_configuration.example.id}"
  availability_zones = data.aws_availability_zones.available.names

  load_balancers = [ "${aws_elb.example.name}" ]
  health_check_type = "ELB"

  min_size             = 2            # Minimum number of instances
  max_size             = 10            # Maximum number of instances
  
  tag {
    key = "name"
    value = "terraform-asg-example"
    propagate_at_launch = true
  }
}

# Create ELB
resource "aws_elb" "example" {
  name               = "terraform-asg-example"
  availability_zones = data.aws_availability_zones.available.names  # Replace with your desired availability zones
  security_groups = [ "${aws_security_group.elb.id}" ]

  # Listener Configuration
  listener {
    instance_port     = "${var.server_port}"
    instance_protocol = "HTTP"
    lb_port           = 80
    lb_protocol       = "HTTP"
  }

  # Health Check Configuration
  health_check {
    target              = "HTTP:${var.server_port}/"
    interval            = 30
    timeout             = 3
    unhealthy_threshold = 2
    healthy_threshold   = 2
  }
}
