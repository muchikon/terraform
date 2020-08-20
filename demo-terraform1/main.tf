provider "aws" {
  region = "us-east-2"
}

resource "aws_instance" "web" {
  ami           = "codigo AMI ya creado"
  instance_type = "t2.micro"

  tags = {
    Name = "terraform-vm"
  }
}