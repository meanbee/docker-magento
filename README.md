# meanbee/magento

A collection of Docker images for running Magento application web servers and command line tools.

# Supported tags and respective `Dockerfile` links

- [`5.6-apache` (*5.6/apache/Dockerfile*)](https://github.com/meanbee/docker-magento/blob/master/5.6/apache/Dockerfile)
- [`5.6-cli` (*5.6/cli/Dockerfile*)](https://github.com/meanbee/docker-magento/blob/master/5.6/cli/Dockerfile)
- [`5.5-apache` (*5.5/apache/Dockerfile*)](https://github.com/meanbee/docker-magento/blob/master/5.5/apache/Dockerfile)
- [`5.5-cli` (*5.5/cli/Dockerfile*)](https://github.com/meanbee/docker-magento/blob/master/5.5/cli/Dockerfile)

# Usage

Since Magento requires several services working together, it recommended to use docker-compose with these images.

A sample `docker-compose.yml` configuration:

    web:
      image: meanbee/magento:5.6-apache
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

# Options

## Xdebug

Xdebug is installed and enabled on all the images by default. To configure it for remote debugging, start
the container with the following environment variable set (replacing the `{}` placeholders with appropriate values):

    XDEBUG_CONFIG="remote_host={IP_ADDRESS} idekey={IDEKEY}"
