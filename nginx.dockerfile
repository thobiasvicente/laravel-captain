FROM nginx:stable-alpine

ADD ./nginx/default.conf /etc/nginx/conf.d/default.conf
ADD ./nginx/nginx.conf /etc/nginx/nginx.conf

RUN mkdir -p /var/www/html

RUN mkdir -p /etc/nginx/certs/mkcert

ADD ./nginx/certs/ /etc/nginx/certs/mkcert