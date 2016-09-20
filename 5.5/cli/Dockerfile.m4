FROM php:5.5-cli

MAINTAINER Tomas Gerulaitis <tomas.gerulaitis@meanbee.com>

include(`dockerfile/extensions.m4')
include(`dockerfile/memcached.m4')
include(`dockerfile/xdebug.m4')
include(`dockerfile/cron.m4')
include(`dockerfile/php-ini.m4')

ENV ION_CUBE_PHP_VERSION "5.5"
include(`dockerfile/ioncube-loader.m4')

include(`dockerfile/entrypoint.m4')
