# meanbee/magento

[![Build Status][ico-travis]][link-travis]
[![Docker Build Status][ico-dockerbuild]][link-dockerhub]
[![Docker Pulls][ico-downloads]][link-dockerhub]
[![Docker Stars][ico-dockerstars]][link-dockerhub]

A collection of Docker images for running Magento application web servers and command line tools.

# Supported tags and respective `Dockerfile` links

- [`7.1-apache` (*7.1/apache/Dockerfile*)](https://github.com/meanbee/docker-magento/blob/master/7.1/apache/Dockerfile)
- [`7.1-cli` (*7.1/cli/Dockerfile*)](https://github.com/meanbee/docker-magento/blob/master/7.1/cli/Dockerfile)
- [`7.1-fpm` (*7.1/fpm/Dockerfile*)](https://github.com/meanbee/docker-magento/blob/master/7.1/fpm/Dockerfile)
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

See [docker-compose.yml](docker-compose.yml) for a sample configuration.

# Options

## Sendmail

All images have sendmail installed for emails, however it is not enabled by default. To enable sendmail, use the following environment variable:

    ENABLE_SENDMAIL=true

*Note:* If sendmail has been enabled, make sure the container has a hostname assigned using the `hostname` field in `docker-compose.yml` or `--hostname` parameter for `docker run`. If the container does not have a hostname set, sendmail will attempt to discover the hostname on startup, blocking for a prolonged period of time.

## Xdebug

Xdebug is installed and enabled on all the images by default. To configure it for remote debugging, start
the container with the following environment variable set (replacing the `{}` placeholders with appropriate values):

    XDEBUG_CONFIG="remote_host={IP_ADDRESS} idekey={IDEKEY}"

# Command Line Tools

The `cli` images have a number of useful Magento tools pre-installed:

- [composer](https://getcomposer.org/) - Install and manage PHP package dependencies
- [mageconfigsync](https://github.com/punkstar/mageconfigsync) - Backup and restore Magento System Configuration
- [magedbm](https://github.com/meanbee/magedbm) - Create development backups of the Magento database using S3 and import them
- magemm - Sync media images from an S3 backup
- [modman](https://github.com/colinmollenhour/modman) - Install Magento extensions
- [magerun](https://github.com/netz98/n98-magerun) - Run command line commands in Magento

All of the installed tools run in the working directory of the container, so don't forget to set it using the `working_dir` service configuration option in `docker-compose.yml` or the `--workdir` parameter to `docker run`.

Some of the commands use additional environment variables for configuration:

 - `AWS_ACCESS_KEY_ID` _(magedbm, magemm)_ Credentials for S3 connections
 - `AWS_SECRET_ACCESS_KEY` _(magedbm, magemm)_ Credentials for S3 connections
 - `AWS_REGION` _(magedbm, magemm)_ S3 region to use
 - `AWS_BUCKET` _(magedbm)_ S3 bucket to use for database backups
 - `AWS_MEDIA_BUCKET` _(magemm)_ S3 bucket to fetch media images from

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

[ico-travis]: https://img.shields.io/travis/meanbee/docker-magento.svg?style=flat-square
[ico-dockerbuild]: https://img.shields.io/docker/build/meanbee/magento.svg?style=flat-square
[ico-downloads]: https://img.shields.io/docker/pulls/meanbee/magento.svg?style=flat-square
[ico-dockerstars]: https://img.shields.io/docker/stars/meanbee/magento.svg?style=flat-square

[link-travis]: https://travis-ci.org/meanbee/docker-magento
[link-dockerhub]: https://hub.docker.com/r/meanbee/magento/
