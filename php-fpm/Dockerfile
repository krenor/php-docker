FROM php:7.2-fpm-alpine

ARG INSTALL_APCU=false
ARG INSTALL_GD=false
ARG INSTALL_MEMCACHED=false
ARG INSTALL_MONGODB=false
ARG INSTALL_OPCACHE=false
ARG INSTALL_PGSQL=false
ARG INSTALL_REDIS=false
ARG INSTALL_XDEBUG=false

ENV MEMCACHED_DEPS \
    cyrus-sasl-dev \
    libmemcached-dev \
    zlib-dev

# Load the pool configuration.
COPY php-fpm/pool.conf \
     /usr/local/etc/php-fpm.d/

# Load additional php configuration files.
COPY php-fpm/configs/* \
     /usr/local/etc/php/conf.d/

# Install additional extensions.
RUN apk upgrade --update && \
    apk add --no-cache --virtual build-dependencies \
        ${PHPIZE_DEPS} && \
    #------------------------------
    # APCu
    #------------------------------
    if [ ${INSTALL_APCU} = true ]; then \
        pecl install apcu && \
        docker-php-ext-enable apcu \
    ;fi && \
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
    # Memcached
    #------------------------------
    if [ ${INSTALL_MEMCACHED} = true ]; then \
        apk add --no-cache --virtual build-dependencies \
            ${MEMCACHED_DEPS} && \
        apk add --no-cache \
            libmemcached && \
        pecl install memcached && \
        docker-php-ext-enable memcached \
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
        docker-php-ext-install \
            pgsql \
            pdo_pgsql \
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

# Load Laravel.
COPY src/ /var/www

# Run as a unique, less privileged user for security reasons.
RUN chown -R www-data /var/www

# Set default working directory.
WORKDIR /var/www

# Expose the port inside the container itself.
EXPOSE 9000
