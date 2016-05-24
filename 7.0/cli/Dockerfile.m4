FROM php:7.0-cli

MAINTAINER Tomas Gerulaitis <tomas.gerulaitis@meanbee.com>

include(`dockerfile/extensions.m4')
include(`dockerfile/xdebug.m4')
include(`dockerfile/cron.m4')
include(`dockerfile/php-ini.m4')

include(`dockerfile/entrypoint.m4')
