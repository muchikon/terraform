## Interpolacion, condiciones, ciclos y grupo de seguridad

Las variables 

**main.tf**
* Se agrego el recurso tipo "aws_security_group" con nombre "ssh_connection".
* Se agrego la variable "sg_name" que se define en el archivo prod.auto.tfvars.
* Se agrego la variable "ingress_rules".
* Se declaro la regla dinamica ingress `dinamic "ingress"`, con esto no se tiene que copiar varios ingress sino se crea uno solo, luego en el archivo prod.auto.tfvars se define la cantidad de puertos se desea crear.
* Dentro del recurso aws_instance se relaciona con el grupo de seguridad por medio de la entrada
`security_groups = ["${aws_security_group.ssh_connection.name}"]`
haciendo referencia al tipo y nombre del recurso del grupo de seguridad.

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
* Se agregaron las definiciones de las variables sg_names e ingress_rules

```
variable "ami_id" {
  default     = ""
  description = "AMI ID"
}

variable "instance_type" {

}

variable "tags" {

}

variable "sg_name" {

}

variable "ingress_rules" {

}
```
**prod.auto.tfvars**
* Cuando tiene el "auto" en el nombre del archivo, ya no se necesita agregar en el parametro de terraform plan, terraform apply, etc.
* Esto se usa cuando no se cambiara las variables del archivo,
si se cambia los parametros mejor es ponerlo sin el "auto" solo seria  "prod.tfvars" y luego se agrega el parametro.
* Se agrega los valores de las variables sg_name e ingress_rules
* El ami-id se obtiene del demo packer que se realizo en capitulos anteriores
es importante porque al final nos conectaremos por ssh.

```
ami_id	= "ami-08122f94xxxxxxxx"
instance_type = "t2.large"
tags	= { Name = "practica2", Environment = "Prod" }
sg_name	= "platzi-rules"
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
```
**output.tf**
* Este archivo se usa para almacenar las variables que deseamos obtener
* En esta caso obtendremos la ip publica en la consola

```
output "instance_ip" {
    value = aws_instance.web.*.public_ip
}
```

Una vez se tenga seteado los valores, si estamos trabajando en otro directorio aplicamos el comando 

```
$ terraform init
```
Si se esta trabajando en el mismo directorio ya no es necesario

```
$ terraform plan 
```
Con el terraform plan validamos que ahora tenemos 2 recursos para añadir

```
$ terraform apply -auto-approve
```
Como el archivo es prod.auto.tfvars ya no es necesario ponerlo como parametro, tambien en la consola se obtiene la IP publica que se usara para conectarse por SSH.
Se tiene que esperara que termine de crear completamente la maquina virtual, eso se valida en la consola AWS.

```
$ ssh -i ~/.ssh/packer-key centos@3.22.101.228  
```

Con ello validas el acceso a la maquina virtual

![image](https://user-images.githubusercontent.com/2185148/90837863-d5912180-e318-11ea-9bcb-fb198658f03d.png)

```
$ terraform destroy -auto-approve
```
Con este comando destruyes la maquina virtual creada

![image](https://user-images.githubusercontent.com/2185148/90837990-39b3e580-e319-11ea-87ba-8ffdedcf495d.png)