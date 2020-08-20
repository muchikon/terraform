## Archivo de definicion de variables

Las variables dentro de Terraform se deben definir e instanciar, una buena práctica es tener definidas las variables en un archivo e instanciarse en otro.

Terraform nos permite usar variables de tipo String, List y Map. A cada variable podemos añadirle un valor por default, una descripción y el tipo de la variable, actualmente Terraform identifica el tipo de variable automáticamente.

El archivo donde asignamos los valores de las variables debe terminar en .tfvars.

Mas informacion de variables esta en la documentacion oficial de Terraform
https://www.terraform.io/docs/configuration/variables.html

main.tf (se encuentra la definición de todos los recursos a crear)
```
provider "aws" {
  region = "us-east-2"
}

resource "aws_instance" "web" {
  ami = var.ami_id    
  instance_type = var.instance_type
  tags = var.tags   
}
```

variables.tf (se encuentran declaradas todas las variables que se utilizaran)
```
variable "ami_id" {
    default=""
    description="AMI ID"   
}

variable "instance_type" {

}

variable "tags" {
  
}
```

dev.tfvars (contendran los valores de las variables declaradas, terraform no es capaz de interpretar estos archivos por lo que es necesario enviarlo como un argumento -var-file dev.tfvars. Se debe enviar este argumento con los commandos plan | appy | destroy)
```
ami_id="ami-0934715xxxxxxxxxx"
instance_type="t2.micro"
tags={Name="practica1",Environment="Dev"}
```

Una vez definido los archivos aplicamos el comando

```
$ terraform init
```
Permite inicializar el nuestro entorno, si ya lo ejecutamos con anterioridad y estamos en el mismo directorio no es necesario volver a ejecutar, si cambias de directorio debes volver a ejecutarlo

```
$ terraform validate
```
Validamos la sintaxis

```
$ terraform plan -var-file dev.tfvars
```
Validamos los recursos que se crearan con la definición, con el parametro -var-file le indicamos  el archivo "dev.tfvars" que tiene las definiciones de las variables.

```
$ terraform apply -var-file dev.tfvars -auto-approve
```
Aplicamos los cambios y con el parametro auto-approve se confirma los cambios y ya no es necesaria la interaccion.

```
$ terraform destroy -var-file dev.tfvars -auto-approve
```
Nos permite destruir la infraestructura creada.