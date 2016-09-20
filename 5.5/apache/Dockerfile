FROM php:5.5-apache

MAINTAINER Tomas Gerulaitis <tomas.gerulaitis@meanbee.com>

RUN build_packages="libmcrypt-dev libpng12-dev libfreetype6-dev libjpeg62-turbo-dev libxml2-dev libxslt1-dev libmemcached-dev sendmail-bin sendmail" \
    && apt-get update && apt-get install -y $build_packages \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install gd \
    && docker-php-ext-install mbstring \
    && docker-php-ext-install mcrypt \
    && docker-php-ext-install pcntl \
    && docker-php-ext-install pdo_mysql \
    && docker-php-ext-install soap \
    && docker-php-ext-install xsl \
    && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN apt-get update \
  && echo "no" | pecl install memcached && docker-php-ext-enable memcached \
  && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN yes | pecl install xdebug && docker-php-ext-enable xdebug

COPY php.ini /usr/local/etc/php/conf.d/zz-magento.ini

RUN a2enmod rewrite headers

COPY magento.conf /etc/apache2/conf-enabled/


ENV ION_CUBE_PHP_VERSION "5.5"
ENV PHP_EXTENSION_DIR "/usr/local/lib/php/extensions/no-debug-non-zts-20121212"
RUN curl http://downloads3.ioncube.com/loader_downloads/ioncube_loaders_lin_x86-64.tar.gz -o /ioncube_loaders_lin_x86-64.tar.gz && \
    tar -xzvf /ioncube_loaders_lin_x86-64.tar.gz -C / && \
    cp "/ioncube/ioncube_loader_lin_${ION_CUBE_PHP_VERSION}.so" $PHP_EXTENSION_DIR && \
    echo "zend_extension=${PHP_EXTENSION_DIR}/ioncube_loader_lin_${ION_CUBE_PHP_VERSION}.so" > /usr/local/etc/php/conf.d/00-ioncube.ini && \
    rm -rf /ioncube /ioncube_loaders_lin_x86-64.tar.gz


ADD entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

CMD ["apache2-foreground"]

