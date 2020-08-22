variable "bucket_name" {
	default = "platzi-terraform1"
}

variable "acl" {
	default = "private"
}

variable "tags" {
	default = {Environment = "Dev", CreatedBy = "terraform"}
}