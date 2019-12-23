FROM php:7.4-apache
MAINTAINER Tomas Gerulaitis <tomas.gerulaitis@meanbee.com>

ENV PHP_EXT_APCU_VERSION "5.1.18"
ENV PHP_EXT_MEMCACHED_VERSION "3.1.5"
ENV PHP_EXT_XDEBUG_VERSION "2.9.0"


RUN build_packages="libpng-dev libfreetype6-dev libjpeg62-turbo-dev libxml2-dev libxslt1-dev libmemcached-dev sendmail-bin sendmail libicu-dev libzip-dev libonig-dev" \
    && apt-get update && apt-get install -y $build_packages \
    && yes "" | pecl install apcu-$PHP_EXT_APCU_VERSION && docker-php-ext-enable apcu \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install gd \
    && docker-php-ext-install mbstring \
    && echo "no" | pecl install memcached-$PHP_EXT_MEMCACHED_VERSION && docker-php-ext-enable memcached \
    && docker-php-ext-install pcntl \
    && docker-php-ext-install pdo_mysql \
    && docker-php-ext-install soap \
    && yes | pecl install xdebug-$PHP_EXT_XDEBUG_VERSION && docker-php-ext-enable xdebug \
    && docker-php-ext-install xsl \
    && docker-php-ext-install zip \
    && docker-php-ext-install intl \
    && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


COPY php.ini /usr/local/etc/php/conf.d/zz-magento.ini

ADD entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

RUN a2enmod rewrite headers

COPY magento.conf /etc/apache2/conf-enabled/

CMD ["apache2-foreground"]
