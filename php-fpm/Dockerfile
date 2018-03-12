FROM php:7.2-fpm-alpine

COPY php-fpm/pool.conf /usr/local/etc/php-fpm.d/
COPY src/ /var/www

WORKDIR /var/www

EXPOSE 9000
