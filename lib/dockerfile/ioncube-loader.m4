RUN curl http://downloads3.ioncube.com/loader_downloads/ioncube_loaders_lin_x86-64_5.1.2.tar.gz -o /ioncube_loaders_lin_x86-64_5.1.2.tar.gz && \
    tar -xzvf /ioncube_loaders_lin_x86-64_5.1.2.tar.gz -C / && \
    cp "/ioncube/ioncube_loader_lin_${PHP_MAJOR_VERSION}.${PHP_MINOR_VERSION}.so" $PHP_EXTENSION_DIR && \
    echo "zend_extension=${PHP_EXTENSION_DIR}/ioncube_loader_lin_${PHP_MAJOR_VERSION}.${PHP_MINOR_VERSION}.so" > /usr/local/etc/php/conf.d/00-ioncube.ini && \
    rm -rf /ioncube /ioncube_loaders_lin_x86-64_5.1.2.tar.gz
