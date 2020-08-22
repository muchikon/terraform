provider "aws" {
	region="us-east-2"
}

resource "aws_s3_bucket" "platzi-backend" {
	bucket = var.bucket_name
	acl = var.acl 
	tags = var.tags
	
}
