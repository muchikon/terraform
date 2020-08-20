provider "aws" {
  region = "us-east-2"
}

resource "aws_instance" "web" {
  ami           = "ami-0934715a22ca8e8aa"
  instance_type = "t2.micro"

  tags = {
    Name = "terraform-vm"
  }
}