FROM php:5.6-fpm

MAINTAINER Tomas Gerulaitis <tomas.gerulaitis@meanbee.com>

include(`dockerfile/extensions.m4')
include(`dockerfile/xdebug.m4')
include(`dockerfile/sendmail.m4')
include(`dockerfile/php-ini.m4')
include(`dockerfile/cleanup.m4')

include(`dockerfile/entrypoint.m4')
include(`dockerfile/cmd-fpm.m4')
