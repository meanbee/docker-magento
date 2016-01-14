FROM php:5.5-cli

MAINTAINER Tomas Gerulaitis <tomas.gerulaitis@meanbee.com>

include(`dockerfile/extensions.m4')
include(`dockerfile/xdebug.m4')
include(`dockerfile/php-ini.m4')
