## Creacion de backend

**main.tf**
* Se agrego un recurso tipo "aws_s3_bucket" con nombre "platzi-backend"
* Se agrego la variable bucket_name declarado en el archivo variables.tf
* Se agrego el acl que es el "access control list"

```
provider "aws" {
	region="us-east-2"
}
resource "aws_s3_bucket" "platzi-backend" {
	bucket = var.bucket_name
	acl = var.acl 
	tags = var.tags	
}
```

**variable.tf**
* El "bucket_name" que se crea en AWS S3 es platzi-terraform

```
variable "bucket_name" {
	default = "platzi-terraform1"
}

variable "acl" {
	default = "private"
}

variable "tags" {
	default = {Environment = "Dev", CreatedBy = "terraform"}
}
```

Una vez se tenga los archivos ejecutamos el comando

```
$ terraform init
```

Luego para validar 
```
$ terraform validate
```
Si no se tiene errores entonces ejecutamos

```
$ terraform apply -auto-approve
```
Con esto crea el bucket en AWS S3

![image](https://user-images.githubusercontent.com/2185148/90945553-23765a00-e3eb-11ea-8e88-85d1f3b5c26a.png)

Ahora se creara un archivo 

**backend.tf**
* En este enlace https://www.terraform.io/docs/backends/types/s3.html tenemos los detalles de las configuraciones de los backends
* bucket = es el bucket que se creara en S3
* key = dentro del bucket platzi-terraform se creara un archivo dev con el contenido del estado de terraform

```
terraform {
  backend "s3" {
    bucket = "platzi-terraform1"
    key    = "dev"
    region = "us-east-2"    
  }
}
```
Hacemos un terraform init para que reconozca el archivo creado.

```
$ terraform init
```
Inicializa el backend, y pregunta se deseamos copiar el estado al nuevo bucket s3, le indicamos que si.

![image](https://user-images.githubusercontent.com/2185148/90945729-4c4b1f00-e3ec-11ea-9e0f-3300de1d399b.png)