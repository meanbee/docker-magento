RUN apt-get update \
  && echo "no" | pecl install memcached && docker-php-ext-enable memcached \
  && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
