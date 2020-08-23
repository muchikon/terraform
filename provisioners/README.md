**Provisioners**

En este capitulo se hablara sobre provisioners que nos permite configurar servidores despues de construirlos.

Mas informacion en este enlace:
https://www.terraform.io/docs/provisioners/index.html

Para la practica nos basaremos en los archivos de modulos-locales
https://github.com/muchikon/terraform/tree/master/modulos-locales

Modificamos el archivo 

**main.tf**

Agregamos en el security group una regla de egreso

```
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
}
```



**variables.tf**

* Se agrega la nueva variable creada de "egress_rules"
* Este cambio se hace en la carpeta instance y en el archivo de la raiz

```
variable "egress_rules" {
}
```

**app.tf**

* Se agrega la nueva regla de egress_rules

```
provider "aws" {
  region = "us-east-2"
}
module "app-platzi" {
	source = "./modulos/instance"
	ami_id = var.ami_id
	instance_type = var.instance_type
	tags = var.tags
	sg_name = var.sg_name
	ingress_rules = var.ingress_rules
	egress_rules = var.egress_rules
}
```

**prod.tfvars**

* En la seccion egress_rules se agrega
* from_port = 0  (que sea todos los puertos)
* to_port = 0  (que sea todos los puertos)
* protocol = "-1"  (esto indica que se conectara a cualquier protocolo)

```
ami_id	= "ami-08122fxxxxxxxxxxx"
instance_type = "t2.large"
tags	= { Name = "practica1", Environment = "Prod" }
sg_name	= "platzi-rules-provisioners"
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
egress_rules = [
	{
		from_port = 0  #que sea todo
		to_port = 0  
		protocol = "-1"  #esto indica que se conectara a cualquier puerto
 		cidr_blocks = ["0.0.0.0/0"]
	}
	]

```

Ejecutamos

```
$ terraform init
```

Luego

```
$ terraform validate
```

No deberia mostrar ningun error, sino toca revisar los archivos

```
$ terraform plan -var-file prod.tfvars
```

Nos muestra que agregara dos recursos

![image](https://user-images.githubusercontent.com/2185148/90967256-2da75f80-e4a2-11ea-98a9-c5e6a6ed96f0.png)

```
$ terraform apply -var-file prod.tfvars -auto-approve
```

Se crean los recursos y nos muestra la IP del servidor creado

![image](https://user-images.githubusercontent.com/2185148/90966266-2da16280-e496-11ea-9e46-23f14fb16f02.png)

Ahora en el archivo

**main.tf**

* En el recurso "aws_instance" se agrega un provisioner "remote-exec"
* type = "ssh" (tipo de conexion)
* user = "centos" (le indicamos el usuario)
* private_key = file("~/.ssh/packer-key")  (La llave a utilizar)
* host = self.public_ip (por default se intenta conectar a la IP privada por eso se indica que se conecte a la IP publica)
* inline: esto realmente hace el aprovisionamiento, este parametro envia la lista de comandos que desee ejecutar dentro la maquina virtual.

```
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
```

Como se agrego cambios en el provisioner y terraform no lo detecta, se va a destruir la infraestructura con el comando 

```
$ terraform destroy -var-file prod.tfvar
```
Luego que termine de destruir lo creado, ejecutamos el comando

```
$ terraform apply -var-file prod.tfvar -auto-approve
```

Una vez que termina de ejecutar

![image](https://user-images.githubusercontent.com/2185148/90969374-50933d00-e4bd-11ea-863f-761704b5ecd9.png)

Validamos la aplicacion levantada en la IP publica

![image](https://user-images.githubusercontent.com/2185148/90969394-abc52f80-e4bd-11ea-9690-ddb1447c4cff.png)

Validamos la pagina interna "hello"

![image](https://user-images.githubusercontent.com/2185148/90969404-d0210c00-e4bd-11ea-9acf-fe747f849f2c.png)

Luego de terminar las practicas no olvidar borrar todo para que amazon no realice cargos en el uso de AWS.

```
$ terraform destroy -var-file prod.tfvar -auto-approve
```
![image](https://user-images.githubusercontent.com/2185148/90969549-54c05a00-e4bf-11ea-8874-4b3df6ec3729.png)