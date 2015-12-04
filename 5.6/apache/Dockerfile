FROM php:5.6-apache

MAINTAINER Tomas Gerulaitis <tomas.gerulaitis@meanbee.com>

RUN build_packages="libmcrypt-dev libpng12-dev libfreetype6-dev libjpeg62-turbo-dev libxml2-dev" \
    && apt-get update && apt-get install -y $build_packages \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install gd \
    && docker-php-ext-install mbstring \
    && docker-php-ext-install mcrypt \
    && docker-php-ext-install pcntl \
    && docker-php-ext-install pdo_mysql \
    && docker-php-ext-install soap

RUN yes | pecl install xdebug && docker-php-ext-enable xdebug

RUN a2enmod rewrite headers

COPY magento.conf /etc/apache2/conf-enabled/

COPY php.ini /usr/local/etc/php/conf.d/zz-magento.ini
