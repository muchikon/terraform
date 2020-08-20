## Terraform Demo1

Para la sintaxis del programa se usa el "HashiCorp Configuration Language (HCL)" mas informacion en este enlace [HCL](https://www.linode.com/docs/applications/configuration-management/introduction-to-hcl/ "HCL")

Creacion del archivo terraform main.tf, la estructura es la siguiente

```
provider “aws” {
  region = ”us-east-2”
}

resource “aws_instance” “terraform-vm” {
  ami = "codigo-ami a usar”
  instance_type = ”t2.micro”
  tags= {
    Name = ”practica1”
    Environment = “”Dev
  }
}
```
**provider: **es el proveedor donde nos vamos a conectar puede ser aws,azure,gcp, etc.
**region:** la region donde nos conectamos
**resource:** los recursos que usaremos
tipo de recurso: "aws_instance"
maquina virtual a crear: "platzi-instance"
Parametros a usar dentro de resources:
ami: codigo AMI de aws que tengas creado
instance_type: tipo de instancia: 
tags: (etiquetas que son parametrizables) por ejemplo Name y Environment

Una vez se tenga listo el archivo usamos el comando 

```
$ terraform init
```
Permite inicializar el nuestro entorno, dependiendo del provider descarga los plugins necesarios.

```
$ terraform validate
```
Este comando es util para validar la sintaxis de los archivos de definición de terraform.

```
$ terraform plan
```
Con este comando es posible ver los recursos que se crearan con la definición que se esta escribiendo.

```
$ terraform apply
```
Con este comando procedemos a crear la infraestructura.
Luego nos pide confirmacion, se escribe "yes" y enter, al final nos sale un mensaje que se aplico los cambios

![image](https://user-images.githubusercontent.com/2185148/90796028-6560ac80-e2d4-11ea-9ea7-dcbaa841e4aa.png)

Validamos en la consola AWS que se creo la maquina virtual

![image](https://user-images.githubusercontent.com/2185148/90796252-ae186580-e2d4-11ea-83de-1ca947dd5bb1.png)

El comando

```
$ terraform destroy
```
Nos permite destruir la infraestructura creada.

![image](https://user-images.githubusercontent.com/2185148/90797896-d608c880-e2d6-11ea-9444-797201508a36.png)

Luego confirmas en la consola AWS que se destruyo la maquina virtual creada