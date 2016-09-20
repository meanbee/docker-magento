RUN PHP_EXTENSION_DIR="$(php-config --extension-dir)" bash -c 'curl http://downloads3.ioncube.com/loader_downloads/ioncube_loaders_lin_x86-64.tar.gz -o /ioncube_loaders_lin_x86-64.tar.gz && \
    tar -xzvf /ioncube_loaders_lin_x86-64.tar.gz -C / && \
    cp "/ioncube/ioncube_loader_lin_${ION_CUBE_PHP_VERSION}.so" $PHP_EXTENSION_DIR && \
    echo "zend_extension=${PHP_EXTENSION_DIR}/ioncube_loader_lin_${ION_CUBE_PHP_VERSION}.so" > /usr/local/etc/php/conf.d/00-ioncube.ini && \
    rm -rf /ioncube /ioncube_loaders_lin_x86-64.tar.gz'
