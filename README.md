# meanbee/magento

A collection of Docker images for running Magento application web servers and command line tools.

# Supported tags and respective `Dockerfile` links

- [`7.0-apache` (*7.0/apache/Dockerfile*)](https://github.com/meanbee/docker-magento/blob/master/7.0/apache/Dockerfile)
- [`7.0-cli` (*7.0/cli/Dockerfile*)](https://github.com/meanbee/docker-magento/blob/master/7.0/cli/Dockerfile)
- [`7.0-fpm` (*7.0/fpm/Dockerfile*)](https://github.com/meanbee/docker-magento/blob/master/7.0/fpm/Dockerfile)
- [`5.6-apache` (*5.6/apache/Dockerfile*)](https://github.com/meanbee/docker-magento/blob/master/5.6/apache/Dockerfile)
- [`5.6-cli` (*5.6/cli/Dockerfile*)](https://github.com/meanbee/docker-magento/blob/master/5.6/cli/Dockerfile)
- [`5.6-fpm` (*5.6/fpm/Dockerfile*)](https://github.com/meanbee/docker-magento/blob/master/5.6/fpm/Dockerfile)
- [`5.5-apache` (*5.5/apache/Dockerfile*)](https://github.com/meanbee/docker-magento/blob/master/5.5/apache/Dockerfile)
- [`5.5-cli` (*5.5/cli/Dockerfile*)](https://github.com/meanbee/docker-magento/blob/master/5.5/cli/Dockerfile)
- [`5.5-fpm` (*5.5/fpm/Dockerfile*)](https://github.com/meanbee/docker-magento/blob/master/5.5/fpm/Dockerfile)

# Usage

Since Magento requires several services working together, it recommended to use docker-compose with these images.

A sample `docker-compose.yml` configuration:

    web:
      image: meanbee/magento:5.6-apache
      hostname: magento.docker
      environment:
        - DOCKER_FIX=
        - VIRTUAL_HOST=magento.docker
        - ENABLE_SENDMAIL=true
      volumes:
        - ./src:/var/www/html
      ports:
        - 80
        - 443
      links:
        - db

    db:
      image: mysql/mysql-server:5.6
      environment:
        - MYSQL_ROOT_PASSWORD=root
        - MYSQL_DATABASE=magento
      ports:
        - 3306

    cron:
      image: meanbee/magento:5.6-cli
      hostname: magento-cron.docker
      command: /run-cron.sh
      environment:
        - ENABLE_SENDMAIL=true
      volumes:
        - ./src:/var/www/html
      links:
        - db

# Options

## Sendmail

All images have sendmail installed for emails, however it is not enabled by default. To enable sendmail, use the following environment variable:

    ENABLE_SENDMAIL=true

*Note:* If sendmail has been enabled, make sure the container has a hostname assigned using the `hostname` field in `docker-compose.yml` or `--hostname` parameter for `docker run`. If the container does not have a hostname set, sendmail will attempt to discover the hostname on startup, blocking for a prolonged period of time.

## Xdebug

Xdebug is installed and enabled on all the images by default. To configure it for remote debugging, start
the container with the following environment variable set (replacing the `{}` placeholders with appropriate values):

    XDEBUG_CONFIG="remote_host={IP_ADDRESS} idekey={IDEKEY}"

# Building

A lot of the configuration for each image is the same, with the difference being the base image that they're extending from.  For this reason we use `php` to build the `Dockerfile` from a set of templates in `src/`.  The `Dockerfile` should still be published to the repository due to Docker Hub needing a `Dockerfile` to build from.

To build all `Dockerfile`s, run the `builder.php` script in the `php:7` Docker image:<!-- Yo dawg, I heard you like Docker images... -->

    docker run --rm -it -v $(pwd):/src php:7 php /src/builder.php

## Adding new images to the build config

The build configuration is controlled by the `config.json` file. Yeah element in the top level hash is a new build target, using the following syntax:

    "<target-name>": {
        "version": "<php-version>",
        "flavour": "<image-flavour>",
        "files": {
            "<target-file-name>": {
                "<template-variable-name>": "<template-variable-value>",
                ...
            },
    }

The target files will be rendered in the `<php-version>/<image-flavour>/` directory.

The source template for each target file is selected from the `src/` directory using the following fallback order:

1. `<target-file-name>-<php-version>-<image-flavour>`
2. `<target-file-name>-<php-version>`
3. `<target-file-name>-<image-flavour>`
4. `<target-file-name>`

Individual templates may include other templates as partials.
