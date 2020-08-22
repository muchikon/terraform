## Encriptado de backend

La documentacion oficial de terraform:
https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket

Se agrega el recurso


**main.tf**
* Se agrego un recurso tipo "aws_kms_key" con nombre "mykey"
* deletion_window_in_days: dias de rotacion de las llaves
* En el recurso aws_s3_bucket se agrepo el server_side_encryption_configuration para encriptar el estado

```
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

**backend.tf**

```
terraform {
  backend "s3" {
    bucket = "platzi-terraform1"
    key    = "dev"
    region = "us-east-2"    
  }
}
```
Ejecutamos el comando

```
$ terraform validate
```
Luego el comando

```
$ terraform apply
```
Nos indica que agregara un recurso y modificara otro, le indicamos que si

![image](https://user-images.githubusercontent.com/2185148/90946408-190b8e80-e3f2-11ea-91b0-ce8768ffa0fd.png)

Al finan nos indicara una linea con el nombre "outputs:" con el arn que se usara en el archivo backends

![image](https://user-images.githubusercontent.com/2185148/90946557-8d92fd00-e3f3-11ea-8aa1-ac132c77dcb9.png)

**backend.tf **

* Archivo modificado

```
terraform {
  backend "s3" {
    bucket = "platzi-terraform2"
    key    = "dev"
    region = "us-east-2"    
	encrypt = true
	kms_key_id = "arn:aws:kms:us-east-2:204749385567:key/b52cf66a-72db-45ef-87d9-fcf05e83aabe"
  }
}
```

El archivo de estado lo maneja el comando terraform init

```
$ terraform init
```

Con esto hemos encriptado el archivo pero un usuario con privilegios siempre podra ver el archivo completo, para validar se crea un usuario con permisos solo para s3 en AWS

![image](https://user-images.githubusercontent.com/2185148/90946741-810fa400-e3f5-11ea-8527-98d653fc6363.png)

Le damos el permiso de read-only

![image](https://user-images.githubusercontent.com/2185148/90946762-ad2b2500-e3f5-11ea-926e-3e94fdeb5a67.png)

Luego ingresamos a la consola de AWS con el usuario creado por medio del link de acceso, vamos a nuestro bucket e intentamos abrir el archivo dev donde esta los registro del estado de terraform.

Nos saldra el siguiente mensaje.

![image](https://user-images.githubusercontent.com/2185148/90946800-10b55280-e3f6-11ea-8765-019343c58c24.png)