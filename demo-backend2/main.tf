provider "aws" {
	region="us-east-2"
}
resource "aws_kms_key" "mykey" {
  description             = "Key State File"
  deletion_window_in_days = 10  
}
resource "aws_s3_bucket" "platzi-backend" {
	bucket = var.bucket_name
	acl = var.acl 
	tags = var.tags
	server_side_encryption_configuration {
        rule {
            apply_server_side_encryption_by_default {
                kms_master_key_id = aws_kms_key.mykey.arn
                sse_algorithm     = "aws:kms"
            }
        }
    }
}
output "arn" {
     value = aws_kms_key.mykey.arn
}