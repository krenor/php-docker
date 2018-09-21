FROM nginx:1.15-alpine

# These values represent the deployment values.
# The nginx and php container get combined into a pod so nginx can reach php-fpm locally.
# During development FASTCGI_BACKEND must be changed to address the php-fpm container name.
ENV SERVER_NAME=localhost \
    FASTCGI_BACKEND=127.0.0.1:9000

# Run as a unique, less privileged user for security reasons.
RUN apk upgrade --update && \
    adduser -D -H -u 1000 -s /bin/sh www-data

# Load main nginx configuration.
COPY ./nginx/nginx.conf \
     /etc/nginx/

# Load individual server configurations.
COPY ./nginx/servers/* \
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
