FROM    composer:1.9 as composer
FROM    php:7.4-fpm-alpine

COPY    --from=composer /usr/bin/composer /usr/local/bin/composer

LABEL   maintainer="Raimundo Matias <raimundo.arlindo@gmail.com>"

# PECL
ENV     APCU_VERSION 5.1.18

# Removing apkindex warnings
RUN     rm -rf /var/cache/apk/* && rm -rf /tmp/* && apk update

# libs and building dependencies
RUN     apk add --update --no-cache \
        git \
        unzip \
        zlib-dev \
        libzip-dev \
        ca-certificates \
        postgresql-libs \
        postgresql-dev \
        && apk add --no-cache --virtual .build-deps \
            $PHPIZE_DEPS \
            curl \
            icu-dev \
        && docker-php-ext-install \
            zip \
            pdo_pgsql \
        && yes | pecl install apcu-${APCU_VERSION} \
        && yes | pecl install xdebug \
        && docker-php-ext-enable apcu \
        && docker-php-ext-enable opcache \
        && apk add --no-cache su-exec \
        && apk del .build-deps

# PHP config
COPY    conf.d/php.ini /usr/local/etc/php
COPY    conf.d/xdebug.ini /usr/local/etc/php/conf.d
RUN     printf "zend_extension=$(find /usr/local/lib/php/extensions/ -name xdebug.so)" >> /usr/local/etc/php/conf.d/xdebug.ini