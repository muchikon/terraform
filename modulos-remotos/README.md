**Modulos remotos**

Los módulos locales son útiles, pero tienen la limitante de que solamente se encuentran en tu máquina. Para mejorar el trabajo remoto y reutilización de módulos podemos usar el control de versiones de preferencia, ya sea GitHub o BitBucket.

Se trabajara con los mismos archivos de modulos-locales

En nuestra cuenta github creamos un repositorio "modulos-remotos"

Vamos a la carpeta local modulos y hacemos un

```
$ git init

```
para inicializar un repositorio

```
$ git remote add origin https://github.com/muchikon/modulos-remotos.git
```
Agregamos el repositorio del repositorio que acabamos de crear

Validamos con:

```
$ git remote -v
origin  https://github.com/muchikon/modulos-remotos.git (fetch)
origin  https://github.com/muchikon/modulos-remotos.git (push)
```

```
$ git add .
```

Con esto subimos el contenido de la carpeta instance que esta dentro de la carpeta modulos.

```
$ git commit -v "creacion de modulos"
```

```
$ git push origin master
```

Con esto ya podemos validar nuestro repositorio en github

Ahora modificamos el archivo

**app.tf**

* En source se pone la ruta del repositorio con las definiciones.

```
provider "aws" {
  region = "us-east-2"
}
module "app-platzi" {
	source = "github.com/muchikon/modulos-remotos/instance"
	ami_id = var.ami_id
	instance_type = var.instance_type
	tags = var.tags
	sg_name = var.sg_name
	ingress_rules = var.ingress_rules
}
```

Ejecutamos

```
$ terraform init
```

Empieza a descargar el modulo de la ruta de github

![image](https://user-images.githubusercontent.com/2185148/90966226-a227d180-e495-11ea-8a92-527141008899.png)

```
$ terraform validate
```

No deberia mostrar ningun error, sino toca revisar los archivos

```
$ terraform plan -var-file prod.tfvars
```

Se agregara dos recursos

![image](https://user-images.githubusercontent.com/2185148/90966243-e31fe600-e495-11ea-86e0-18dc95c03ff0.png)

```
$ terraform apply -var-file prod.tfvars
```

Se crean los recursos y nos muestra la IP del servidor creado

![image](https://user-images.githubusercontent.com/2185148/90966266-2da16280-e496-11ea-9e46-23f14fb16f02.png)

Es preferible borrar las maquinas virtuales para evitar un cobro a fin de mes.

Esto lo hacemos con 

```
$ terraform destroy -var-file prod.tfvars
```

![image](https://user-images.githubusercontent.com/2185148/90966306-aef8f500-e496-11ea-8ba4-e637645d1a3b.png)