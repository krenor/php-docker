FROM nginx:1.13-alpine

RUN apk upgrade --update && \
    adduser -D -H -u 1000 -s /bin/sh www-data

WORKDIR /var/www

EXPOSE 80 443

CMD ["nginx", "-g", "daemon off;"]
