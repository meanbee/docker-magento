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
      volumes:
        - ./src:/var/www/html
      links:
        - db

# Options

## Xdebug

Xdebug is installed and enabled on all the images by default. To configure it for remote debugging, start
the container with the following environment variable set (replacing the `{}` placeholders with appropriate values):

    XDEBUG_CONFIG="remote_host={IP_ADDRESS} idekey={IDEKEY}"

# Building

A lot of the configuration for each image is the same, with the difference being the base image that they're extending from.  For this reason `m4` is used as a templating engine to include partials stored in `lib/` into the `Dockerfile`.  The `Dockerfile` should still be published to the repository due to Docker Hub needing a `Dockerfile` to build from.

To build all `Dockerfile`s use make:

    make

To build a specific `Dockerfile`, use make with the path to the `Dockerfile`, e.g.:

    make 7.0/apache/Dockerfile
