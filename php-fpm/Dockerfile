FROM php:7.2-fpm-alpine

ARG INSTALL_MONGODB=false
ARG INSTALL_REDIS=false

COPY php-fpm/pool.conf \
     /usr/local/etc/php-fpm.d/

COPY php-fpm/php.ini \
     /usr/local/etc/php/conf.d/

RUN apk upgrade --update && \
    apk add --no-cache --virtual build-dependencies \
      autoconf \
      build-base && \
    #------------------------------
    # MongoDB
    #------------------------------
    if [ ${INSTALL_MONGODB} = true ]; then \
        pecl install mongodb && \
        docker-php-ext-enable mongodb \
    ;fi && \
    #------------------------------
    # Redis
    #------------------------------
    if [ ${INSTALL_REDIS} = true ]; then \
        pecl install redis && \
        docker-php-ext-enable redis \
    ;fi && \
    #------------------------------
    # Cleanup
    #------------------------------
    rm -rf \
      /tmp/*  \
      /var/cache/apk/* \
      /var/tmp/* && \
    apk del \
      build-dependencies

COPY src/ /var/www

WORKDIR /var/www

EXPOSE 9000
