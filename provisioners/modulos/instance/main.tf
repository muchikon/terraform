provider "aws" {
  region = "us-east-2"
}

resource "aws_security_group" "ssh_connection" {
  name        = var.sg_name

  dynamic "ingress" {  
    for_each = var.ingress_rules  
    content {
        from_port   = ingress.value.from_port
        to_port     = ingress.value.to_port
        protocol    = ingress.value.protocol
        cidr_blocks = ingress.value.cidr_blocks
    }
    
  }
  
  dynamic "egress" {  
    for_each = var.egress_rules  
    content {
        from_port   = egress.value.from_port
        to_port     = egress.value.to_port
        protocol    = egress.value.protocol
        cidr_blocks = egress.value.cidr_blocks
    }
    
  }

  tags = {
    Name = "allow_tls"
  }
}

resource "aws_instance" "web" {
  ami           = var.ami_id
  instance_type = var.instance_type
  tags          = var.tags
  security_groups = ["${aws_security_group.ssh_connection.name}"]
  provisioner "remote-exec" {
	connection {
		type = "ssh"
		user = "centos"
		private_key = file("~/.ssh/packer-key")
		host = self.public_ip
		}
		inline = ["echo hello",
		"sudo yum install docker-ce docker-ce-cli containerd.io -y",
		"sudo systemctl start docker",
		"sudo groupadd docker",
		"sudo usermod -aG docker centos",
		"docker run -it -d -p 80:80 muchikon/nginx-app:v1"]
  }
}