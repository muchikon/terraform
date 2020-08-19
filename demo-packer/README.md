## Packer

En esta demo se creara un AMI en AWS

En la carpeta scripts estan los archivos "install-docker.sh" y la llave publica "packer-key.pub" que se crea con el siguiente comando.

```
$ ssh-keygen -f ~/.ssh/packer-key -t rsa
```
Este comando generará 2 archivos "packer-key" que contiene la llave privada y "packer-key.pub" que contiene la llave publica. La llave publica sera usado por el archivo "aws-ami.json"

Otro requisito previo es que ya se tenga el codigo AMI que se usara en el archivo "aws-ami.json"

Primero se crea una maquina virtual con Centos 7 en la consola del AWS luego ingresas por medio de SSH y configuras el repo de Docker que luego sera usado por el script "install-docker.sh"

```
$ sudo yum install -y yum-utils
$ sudo yum-config-manager \
  --add-repo \
https://download.docker.com/linux/centos/docker-ce.repo
```

Ya teniendo instalado el repo creas la imagen

![image](https://user-images.githubusercontent.com/2185148/90694957-246a8880-e23f-11ea-9c89-19a97f36a498.png)

Una vez creada la iamgen en la seccion Images --> AMIs en la parte derecha hay una seccion"AMI ID" es lo que se copia en el archivo aws-ami.json en la seccion "source_ami"

![image](https://user-images.githubusercontent.com/2185148/90696025-2e8d8680-e241-11ea-82cb-e736ba25dd6e.png)

El codigo "owners" se obtiene del "Account ID" que es la cuenta con la que ingresas a la consola de AWS

![image](https://user-images.githubusercontent.com/2185148/90696637-3ef23100-e242-11ea-8404-0f84e106c273.png)

En el archivo aws-ami.json estan configurada las variables de entorno que 
en Windows se crea por medio del Powershell
```
$env:AWS_ACCESS_KEY_ID="clave"
$env:AWS_SECRET_ACCESS_KEY="clave"
```
Y se valida con el comando
```
Get-ChildItem Env:
```
Tanto el "access_key_id" como el "secret_access_key" se obtienen del archivo "descargar.csv", en la seccion cuando se creo el usuario en el IAM de la consola de Amazon.

Una vez se tenga los prerequisitos ya podemos validar el archivo aws-ami.json

```
$ packer validate aws-ami.json
```
Validamos que no tengamos ningun error de sintaxis.

Luego ejecutamos

```
$ packer build aws-ami.json
```
Empezara a crear un AMI en la instancia AWS 

![image](https://user-images.githubusercontent.com/2185148/90697949-2d5e5880-e245-11ea-9e3f-6cda020608e3.png)
