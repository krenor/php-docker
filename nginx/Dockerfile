FROM nginx:1.13-alpine

ENV SERVER_NAME=localhost \
    FASTCGI_BACKEND=127.0.0.1:9000

RUN apk upgrade --update && \
    adduser -D -H -u 1000 -s /bin/sh www-data

# Load main nginx configuration.
COPY ./nginx/nginx.conf \
     /etc/nginx/

# Load individual server configurations.
COPY ./nginx/default.conf \
     /etc/nginx/conf.d/

# Load entrypoint shell script.
COPY ./nginx/entrypoint.sh /

# Load static files directory.
COPY ./src/public/ \
     /var/www/public/

# Set default working directory.
WORKDIR /var/www

# Expose the port inside the container itself.
EXPOSE 80

# Run entrypoint shell script.
ENTRYPOINT ["/entrypoint.sh"]

# Start nginx.
CMD ["nginx"]
