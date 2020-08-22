variable "bucket_name" {
	default = "platzi-terraform2"
}

variable "acl" {
	default = "private"
}

variable "tags" {
	default = {Environment = "Dev", CreatedBy = "terraform"}
}