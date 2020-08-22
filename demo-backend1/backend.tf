terraform {
  backend "s3" {
    bucket = "platzi-terraform1"
    key    = "dev"
    region = "us-east-2"    
  }
}