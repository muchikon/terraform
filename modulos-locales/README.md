**Modulos locales**

Así como en lenguajes de programación contamos con librerías, en Terraform podemos separar nuestro código y reutilizarlo a través de módulos. Dentro de nuestro módulo vamos a añadir el archivo de configuración y el de definición de variables.

Para la practica nos basamos en los archivos del capitulo de interpolacion, se trabajara con el archivo prod.tfvars.

https://github.com/muchikon/terraform/tree/master/interpolacion

Creamos la carpeta modulos y dentro la carpeta instance, luego movemos los archivos main.tf, variable.tf y output.tf a este ultimo directorio.

En la raiz creamos el archivo con el contenido

**app.tf**

* Se define el modulo "app-platzi" con la ruta donde estan los archivos de definicion.
* Se pone las variables usadas en variables.tf

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
}
```

**output.tf**

* En la raiz declaramos este archivo que llamara al archivo hijo que esta en la carpeta instance.
* Se llama el nombre del modulo que se declaro en app.tf "app-platzi" y la etiqueta que se puso al output hijo.
* Esto es para obtener la IP de la maquina que se creara para luego accesar por medio de ssh

```
output "modulo_instance_ip" {
    value = module.app-platzi.instance_ip
}
```

**variables.tf**

Se declara las variables en la raiz, en este caso son las mismas que estan en la carpeta instancia dentro de modulos

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
**prod.tfvars**
* Es el mismo archivo que se estuvo trabajando en la demo de interpolacion

```
ami_id	= "ami-08122f*********"
instance_type = "t2.large"
tags	= { Name = "practica3", Environment = "Prod" }
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

Una vez se tenga los archivos en la raiz con la carpeta module/instance y los archivos main.tf, variables.tf y output.tf

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
Con el comando plan veremos que creara 2 recursos y destruira 2 recursos

![image](https://user-images.githubusercontent.com/2185148/90962397-3b92bb80-e475-11ea-8794-2ff8581de504.png)

```
$ terraform apply -var-file prod.tfvars
```
Nos saldra un error, porque los recursos aun no se terminaron de destruir por eso no se pueden crear los nuevos recursos
![image](https://user-images.githubusercontent.com/2185148/90962425-70067780-e475-11ea-85f2-bf02a4b81cd3.png)

```
$ terraform apply -var-file prod.tfvars
```
Ejecutamos nuevamente el comando esta vez ya se pudo crear los recursos 

![image](https://user-images.githubusercontent.com/2185148/90962452-ba87f400-e475-11ea-92ad-86ae5f3076c5.png)

Con ayuda del archivo output.tf obtenemos la IP del recurso creado y nos conectamos por ssh con la llave packer-key

![image](https://user-images.githubusercontent.com/2185148/90962492-210d1200-e476-11ea-857d-fc2e21071500.png)