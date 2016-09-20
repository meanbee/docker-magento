FROM php:5.5-fpm

MAINTAINER Tomas Gerulaitis <tomas.gerulaitis@meanbee.com>

include(`dockerfile/extensions.m4')
include(`dockerfile/memcached.m4')
include(`dockerfile/xdebug.m4')
include(`dockerfile/php-ini.m4')

ENV ION_CUBE_PHP_VERSION "5.5"
ENV PHP_EXTENSION_DIR "/usr/local/lib/php/extensions/no-debug-non-zts-20121212"
include(`dockerfile/ioncube-loader.m4')

include(`dockerfile/entrypoint.m4')
include(`dockerfile/cmd-fpm.m4')
