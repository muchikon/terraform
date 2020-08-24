## Docker Demo


# Nos autenticamos en Docker Hub

```
$ docker login
```

Construimos la imagen con el dockerfile que esta en la carpeta nginx-app

```
FROM nginx
COPY nginx.conf /etc/nginx/nginx.conf
COPY hello-world.conf /etc/nginx/conf.d/hello-world.conf
RUN mkdir -p /usr/share/nginx/public/hello
COPY index.html /usr/share/nginx/html/hello/index.html
EXPOSE 80
```

Hacemos docker build

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