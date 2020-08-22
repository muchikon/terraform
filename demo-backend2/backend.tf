terraform {
  backend "s3" {
    bucket = "platzi-terraform2"
    key    = "dev"
    region = "us-east-2"    
	encrypt = true
	kms_key_id = "arn:aws:kms:us-east-2:204749385567:key/b52cf66a-72db-45ef-87d9-fcf05e83aabe"
  }
}