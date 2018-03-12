FROM nginx:1.13-alpine

RUN apk upgrade --update && \
    adduser -D -H -u 1000 -s /bin/sh www-data

# Load main nginx configuration.
COPY ./nginx/nginx.conf \
     /etc/nginx/

# Set default working directory.
WORKDIR /var/www

# Expose the ports inside the container itself.
EXPOSE 80 443

# Start nginx.
CMD ["nginx"]
