provider "aws" {
  region = "ap-south-1"
}

resource "aws_db_instance" "myinstance" {
  engine               = "mysql"
  identifier           = "myrdsinstance"
  allocated_storage    = 10   # Increased allocated storage to 20 GB (Free Tier limit)
  engine_version       = "8.0.35"
  instance_class       = "db.t3.micro"
  username             = "admin"
  password             = "admin123" #password must be greater than 8 Characters
  skip_final_snapshot  = true

  # Tags for the RDS instance (optional)
  tags = {
    Name = "MyRDSInstance"
  }
}
