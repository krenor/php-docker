FROM php:7.2-fpm-alpine

ARG INSTALL_GD=false
ARG INSTALL_MONGODB=false
ARG INSTALL_OPCACHE=false
ARG INSTALL_PGSQL=false
ARG INSTALL_REDIS=false
ARG INSTALL_XDEBUG=false

COPY php-fpm/pool.conf \
     /usr/local/etc/php-fpm.d/

COPY php-fpm/configs/* \
     /usr/local/etc/php/conf.d/

RUN apk upgrade --update && \
    apk add --no-cache --virtual build-dependencies ${PHPIZE_DEPS} && \
    #------------------------------
    # GD
    #------------------------------
    if [ ${INSTALL_GD} = true ]; then \
        apk add --no-cache \
            libjpeg-turbo-dev \
            freetype-dev \
            libpng-dev && \
        docker-php-ext-configure gd \
            --with-freetype-dir=/usr/include/freetype2 \
            --with-jpeg-dir=/usr/lib \
            --with-png-dir=/usr/lib && \
        docker-php-ext-install gd \
    ;fi && \
    #------------------------------
    # MongoDB
    #------------------------------
    if [ ${INSTALL_MONGODB} = true ]; then \
        pecl install mongodb && \
        docker-php-ext-enable mongodb \
    ;fi && \
    #------------------------------
    # OPCache
    #------------------------------
    if [ ${INSTALL_OPCACHE} = true ]; then \
        docker-php-ext-install opcache \
    ;else \
        rm /usr/local/etc/php/conf.d/opcache.ini \
    ;fi && \
    #------------------------------
    # PostgreSQL
    #------------------------------
    if [ ${INSTALL_PGSQL} = true ]; then \
        apk add --no-cache postgresql-dev && \
        docker-php-ext-install pgsql pdo_pgsql \
    ;fi && \
    #------------------------------
    # Redis
    #------------------------------
    if [ ${INSTALL_REDIS} = true ]; then \
        pecl install redis && \
        docker-php-ext-enable redis \
    ;fi && \
    #------------------------------
    # XDebug
    #------------------------------
    if [ ${INSTALL_XDEBUG} = true ]; then \
        pecl install xdebug && \
        docker-php-ext-enable xdebug \
    ;else \
        rm /usr/local/etc/php/conf.d/xdebug.ini \
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
