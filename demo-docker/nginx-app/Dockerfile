FROM nginx
COPY nginx.conf /etc/nginx/nginx.conf
COPY hello-world.conf /etc/nginx/conf.d/hello-world.conf
RUN mkdir -p /usr/share/nginx/public/hello
COPY index.html /usr/share/nginx/html/hello/index.html
EXPOSE 80