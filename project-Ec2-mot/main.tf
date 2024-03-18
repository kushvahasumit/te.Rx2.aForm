provider "aws" {
  region = "ap-south-1"
}

module "Ec2" {
  source = "./module/Ec2"
  ami = "ami-007020fd9c84e18c7" 
  instance_type = "t2.micro"
  subnet_id = "subnet-02d1c26f33c4ddc11"
}