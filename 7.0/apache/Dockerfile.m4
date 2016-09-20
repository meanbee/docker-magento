FROM php:7.0-apache

MAINTAINER Tomas Gerulaitis <tomas.gerulaitis@meanbee.com>

include(`dockerfile/extensions.m4')
include(`dockerfile/xdebug.m4')
include(`dockerfile/php-ini.m4')
include(`dockerfile/apache.m4')

ENV ION_CUBE_PHP_VERSION "7.0"
include(`dockerfile/ioncube-loader.m4')

include(`dockerfile/entrypoint.m4')
include(`dockerfile/cmd-apache.m4')
