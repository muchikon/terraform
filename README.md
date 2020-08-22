# Terraform
Infraestructura como codigo (IAC)

## Capitulo 1
Es una practica que utiliza principios de desarrollo de software buscando automatizar los procesos de crear infraestructura.
Los principios que siguen son:
- Se puede reproducir facilmente (Si tengo archivo de definicion se puede automatizar)
- Son desechables
- Los sistemas son consistentes (Se deberia reflejar lo que se definido)
- Son repetibles
- El diseño siempre esta cambiando (Si ya se tiene definido es mas facil hacer cambios)

Practicas generales
- Utilizar archivos de definicion
- Sistemas y procesos documentados (Podemos reutilizar el codigo)
- Versionar todas las cosas (Trazar los cambios que se hacen)
- Preferir cambios pequeños (practica de la metodologia agil, para no impactar)
- Mantener los servicios continuamente disponibles

## Capitulo 2
Tipos de herramientas para implementar IAC
Herramientas para definicion de infraestructura: Permiten especificar que recursos de infraestructura desean crear y como deben configurarse
Archivos de definicion de configuracion: Utiles para impulsar la automatizacion
Ejemplo:
> Crea una subnet y una instancia en AWS

![](https://i.imgur.com/LRm1rXU.jpg)


Herramientas para configuracion de servidores: Permiten configurar los servidores con el estado deseado

Aprovisionamiento: Es el proceso que permite que un elemento este listo para usar, Ejemplo tener todas las dependencias ya listas.

Diferentes enfoques para la gestion de servidores
- Configuracion de servidores (desde un archivo de definicion)
- Empaquetar plantillas de servidores (Por ejemplo snapshots)
- Ejecutar comandos en los servidores (de forma remoto)
- Configuracion desde un registro central

Factores a tomar en cuenta para elegir una herramienta
- Modo desatendido para herramientas de lineas de comando ()
- Idempotencia (ejecutar un script n veces sin error)
- Parametrizable (Para reutirlizar las definiciones que creamos)

Objetivos de la gestion automatizada de servidores
- Un nuevo servidor puede ser aprovisionado a demanda
- Un nuevo servidor puede ser aprovisionado sin intervencion humana
- Cada cambio puede ser aplicado a un conjunto de servidores.

Herramientas para definir y configurar infraestructura
Definicion de infraestructura:
- Terraform (Se puede usar en varios proveedores de nube)
- Cloud Formation (Solo AWS)
- Open stack heat (Solo OpenStack)

Configuracion de Servidores:
- Ansible
- Chef
- Puppet

## Capitulo 3
Beneficios de la IAC
- Creacion rapida bajo demanda (con los archivos de configuracion)
- Automatizacion (creacion y configuracion sin intervencion humana)
- Visibilidad y trazabilidad, todos los cambios quedan registrados (registro de cambios a traves de control de versiones)
- Ambientes homogeneos, una misma definicion permite crear varios ambientes (crear varios ambientes a partir de las mismas configuraciones)
- Facil de testear (Existen herramientas para testear la creacion y configuracion)
## Capitulo 4

![](https://i.imgur.com/ZPtUTRF.jpg)

¿Que es Terraform?
- Open Source
- Creado por Hashicorp
- Desarrollado en Go
- Crear y administrar infraestructura

¿Como funciona?
Terraform interactua con las APIs de los proveedores de nube publica(GCP,AWS,Azure) o privada(Openstack, vsphere)

Caracteristicas clave de terraform
- Es una herramienta de infraestructura como codigo
- Tiene planes de ejecucion (tiene un comando para planificar)
- Facil de automatizar

## Capitulo 5
Terraform vs otras herramientas de IAC

**Creacion y configuración de infraestructura**

**Ansible:** Para gestion de las configuraciones

**Terraform:** Para administrar la infraestructura

**Infraestructura mutable:** Es cuando el estado de un servidor cambia
> Ejemplo: cuando se lanza la nueva version y el aplicativo lo enlaza todo en el mismo servidor 

![](https://i.imgur.com/AlGhUgF.jpg)

**Infraestructura inmutable:** Es cuando se destruye un servidor y se crea uno nuevo con los cambios

> Ejemplo: La instancia A es la version antigua que se elimina y la instancia B es la nueva version que se implementa en otro servidor.

![](https://i.imgur.com/c5Zlc7Q.jpg)

**Lenguaje declarativo:** Le decimos a nuestra herramienta que hacer 

> Ejemplo: En Terraform si le digo que cree 15 instancias y previamente ya creo 10 entonces solo crea 5 instancias mas

![](https://i.imgur.com/aWhWy88.jpg)

**Lenguaje procedural o imperativo:** Le decimos especificamente como hacerlo

> Ejemplo: En cambio en Ansible si le digo que me cree 15 instancias y ya existe 10 creadas anteriormente, lo que hace Ansible es crear 15 instancias 

![](https://i.imgur.com/yJ8FLql.jpg)

## Capitulo 6

Herramientas para construir infraestructura inmutable

**Packer:** Es una herramienta creada por hashicorp para crear imagenes en cualquier nube,
usa formato JSON

![](https://i.imgur.com/KpGWJfx.jpg)

variables: aca definimos las variables que vamos a utilizar, se puede tomar variables de entorno

builders: definimos de donde vamos a construir nuestra iamgen base

provisioners: aca personalizamos nuestra imagen, añadir paquetes, crear directorios, actualizar paquetes.

post-processor: podemos tener archivos de salida y ejecutar comandos despues de haber creado la infraestructura, todo corre de manera local

## Capitulo 7

**Instalacion de Terraform:**
<https://www.terraform.io/downloads.html>

Una vez descargado el instalador se debe guardar en una ruta, en la variable de entorno de windows PATH la modificamos

![](https://i.imgur.com/1xUmEFb.jpg)

Y ponemos la ruta 

![](https://i.imgur.com/Cy1veJU.jpg)

**Instalacion de Packer:**

Como ya se realizo el proceso con Terraform ahora solo guardamos el instalador de packer en la misma ruta que el terraform

<https://www.packer.io/downloads.html>

Otra manera es instalar packer por medio de chocolatey que es un "open-source package management system para Windows"
<https://learn.hashicorp.com/tutorials/packer/getting-started-install>

Para validar en el powershell ejecutaremos los comandos:

`terraform version`

`packer version`

![](https://i.imgur.com/c32eORf.jpg)

## Capitulo 8

Credenciales de AWS en Windows (Previamente ya deberias tener un cuenta AWS para seguir con lo indicado)

https://portal.aws.amazon.com/billing/signup#/start

Se debe crear un usuario en IAM de AWS

![](https://i.imgur.com/6c44d4A.jpg)

Y darle los permisos respectivos

![image](https://user-images.githubusercontent.com/2185148/90545266-ff4a1d00-e14d-11ea-85a3-e5f359b74c39.png)

![image](https://user-images.githubusercontent.com/2185148/90552335-4806d380-e158-11ea-9d7c-ebbdd5bf1e43.png)

Se crea sin etiquetas

Descargamos el archivo csv con las credenciales

![image](https://user-images.githubusercontent.com/2185148/90556543-bc447580-e15e-11ea-9ed6-b452d395ebed.png)

En windows se crea un archivo credentials con el Powershell

`PS C:\users\usuario> mkdir .aws`

`PS C:\users\usuario> cd .\.aws\`

En esta ruta se crea el archivo creddentials

`PS C:\users\usuario\.aws>` 

En amazon hay una guia para configurar las credenciales
https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-files.html

reemplazamos los valores de access_key y scret_keys por los valores del archivo csv que guardamos anteriormente

    [default]
    aws_access_key_id=AKIAIOSFODNN7EXAMPLE
    aws_secret_access_key=wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY

## Capitulo 9

[Packer Demo](https://github.com/muchikon/terraform/tree/master/demo-packer "Packer Demo")

## Capitulo 10

**Docker: Conceptos Clave**

Docker es una herramienta que nos permite crear infraestructura inmutable permitiéndonos encapsular y portar nuestras aplicaciones en una misma imagen logrando que instanciemos la misma imagen la cantidad de veces que queramos.

Imagen: Es una capa creada a partir de un archivo Dockerfile donde definimos la imagen base, todos los paquetes que vayamos a utilizar, directorios, etc.

Container: Un container es una instancia de una imagen de Docker. No tienen estado, no deben guardar ningún tipo de información.

Ejemplo de archivo dockerfile

![image](https://user-images.githubusercontent.com/2185148/90701610-9a2a2080-e24e-11ea-9cb6-e698bf270a5c.png)

## Capitulo 11

[Docker Demo](https://github.com/muchikon/terraform/tree/master/demo-docker "Docker Demo")

## Capitulo 12

Instalar terraform y configurar una cuenta de AWS, se vio en capitulos anteriores

## Capitulo 13

[Terraform1 Demo](https://github.com/muchikon/terraform/tree/master/demo-terraform1 "Terraform1 Demo")

## Capitulo 14

Lista de proveedores Terraform:
https://www.terraform.io/docs/providers/index.html

![image](https://user-images.githubusercontent.com/2185148/90802442-df952f00-e2dc-11ea-9cd4-5b7293c58164.png)

## Capitulo 15

[Archivos de definicion y variables](https://github.com/muchikon/terraform/tree/master/variables "Archivos de definicion y variables")

## Capitulo 16

[Interpolacion, condiciones y ciclos](https://github.com/muchikon/terraform/tree/master/interpolacion "Interpolacion, condiciones y ciclos")

## Capitulo 17

[Security groups](https://github.com/muchikon/terraform/tree/master/interpolacion "Security groups")

## Capitulo 18

**Archivo de estados**

Terraform utiliza un estado donde almacena todas las configuraciones que vayas realizando, este archivo se llama `terraform.tfstate`. Este archivo en formato JSON contiene toda la información respecto a nuestra infraestructura, tambien almacena las credenciales

Debemos tener cuidado al manejar información sensible si utilizamos nuestro archivo sin encriptación ya que toda la información es visible.



## Capitulo 19

**Archivo de Backends**

Terraform permite almacenar el estado de manera remota a través de Backends. Podemos almacenarlo en diferentes servicios de storage en la nube como S3, GCP,Azure,etc.

Entre sus muchas ventajas que trae el trabajar con backends son:

* Es más fácil trabajar en equipo. (Tenemos el archivo centralizado)
* Facilita la integración continua.
* Mayor disponibilidad.

Los tipos de backend soportados por terraform son:
https://www.terraform.io/docs/backends/types/index.html
Algunos de ellos no tienen encriptacion.

Ejemplo con S3

```
terraform {
  backend "s3" {
    bucket = "mybucket"
    key    = "path/to/my/key"
    region = "us-east-1"
  }
}
```

## Capitulo 20

**[Creacion de backend](https://github.com/muchikon/terraform/tree/master/demo-backend1 "Creacion de backend")**


## Capitulo 21

[**Encriptado del backend**](https://github.com/muchikon/terraform/tree/master/demo-backend2 "**Encriptado del backend**")

## Capitulo 22

**Tips de la vida real: Trabajo en equipo con backends**

* Es una buena práctica tener el archivo de estado almacenado y versionado en algún Cloud Provider.
* Encriptar nuestro archivo de estado.
* Versionar nuestro backend.

## Capitulo 23

[**Modulos locales**](https://github.com/muchikon/terraform/tree/master/modulos-locales "**Modulos locales**")

## Capitulo 24

**Modulos remotos**

