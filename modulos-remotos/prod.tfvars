ami_id	= "ami-08122f9xxxxxxxxx"
instance_type = "t2.large"
tags	= { Name = "practica3", Environment = "Prod" }
sg_name	= "platzi-rules-remoto"
ingress_rules = [
	{
		from_port = "22"
		to_port = "22"
		protocol = "tcp"
		cidr_blocks = ["0.0.0.0/0"]
	},
	{
		from_port = "80"
		to_port = "80"
		protocol = "tcp"
		cidr_blocks = ["0.0.0.0/0"]
	}
	]