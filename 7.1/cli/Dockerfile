FROM php:7.1-cli
MAINTAINER Tomas Gerulaitis <tomas.gerulaitis@meanbee.com>

ENV PHP_EXT_APCU_VERSION "5.1.7"
ENV PHP_EXT_MEMCACHED_VERSION "3.0.3"
RUN build_packages="libmcrypt-dev libpng12-dev libfreetype6-dev libjpeg62-turbo-dev libxml2-dev libxslt1-dev libmemcached-dev sendmail-bin sendmail libicu-dev" \
    && apt-get update && apt-get install -y $build_packages \
    && yes "" | pecl install apcu-$PHP_EXT_APCU_VERSION && docker-php-ext-enable apcu \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install gd \
    && docker-php-ext-install mbstring \
    && docker-php-ext-install mcrypt \
    && echo "no" | pecl install memcached-$PHP_EXT_MEMCACHED_VERSION && docker-php-ext-enable memcached \
    && docker-php-ext-install pcntl \
    && docker-php-ext-install pdo_mysql \
    && docker-php-ext-install soap \
    && yes | pecl install xdebug && docker-php-ext-enable xdebug \
    && docker-php-ext-install xsl \
    && docker-php-ext-install zip \
    && docker-php-ext-install intl \
    && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


COPY php.ini /usr/local/etc/php/conf.d/zz-magento.ini

ADD entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

ENV BIN_DIR "/usr/local/bin"
RUN apt-get update \
    && apt-get install -y cron git groff mysql-client python-pip rsyslog sudo \
    && pip install awscli \
    && curl -sS https://getcomposer.org/installer | php -- --install-dir=$BIN_DIR --filename=composer \
    && curl -sS -L https://github.com/punkstar/mageconfigsync/releases/download/0.4.0/mageconfigsync-0.4.0.phar -o $BIN_DIR/mageconfigsync && chmod +x $BIN_DIR/mageconfigsync \
    && curl -sS https://s3-eu-west-1.amazonaws.com/magedbm-releases/magedbm.phar -o $BIN_DIR/magedbm.phar && chmod +x $BIN_DIR/magedbm.phar \
    && curl -sS https://files.magerun.net/n98-magerun.phar -o $BIN_DIR/n98-magerun.phar && chmod +x $BIN_DIR/n98-magerun.phar \
    && curl -sS https://raw.githubusercontent.com/colinmollenhour/modman/master/modman -o $BIN_DIR/modman && chmod +x $BIN_DIR/modman \
    && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY bin/* $BIN_DIR/
ADD run-cron.sh /run-cron.sh

CMD ["php", "-a"]
