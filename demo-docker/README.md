## Docker Demo

```
# Nos autenticamos en Docker Hub
$ docker login
```

Construimos la imagen con el dockerfile
```
docker build -t [DOCKERHUB_USER]/nginx-app:v1 --no-cache .
```

Ejecutamos la app

```
docker run -it -p 3003:80 [DOCKERHUB_USER]/ngnix-app:v1 
```

![image](https://user-images.githubusercontent.com/2185148/90711009-46770180-e265-11ea-8fb4-07d54afd414a.png)

Se publica la imagen en docker hub

```
docker push [DOCKERHUB_USER]/ngnix-app:v1 
```