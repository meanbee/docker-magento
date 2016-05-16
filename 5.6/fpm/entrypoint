#!/usr/bin/env bash

[ "$DEBUG" = "true" ] && set -x

# Setup Magento cron
if [ "$ENABLE_CRON" = "true" ]; then
    echo "* * * * * root su www-data -s /bin/bash -c 'sh $MAGE_ROOT_DIR/cron.sh'" > /etc/cron.d/magento
    /etc/init.d/cron start
fi

# Start sendmail
/etc/init.d/sendmail start

# Configure Xdebug
if [ "$XDEBUG_CONFIG" ]; then
    echo "" > /usr/local/etc/php/conf.d/zz-xdebug.ini
    for config in $XDEBUG_CONFIG; do
        echo "xdebug.$config" >> /usr/local/etc/php/conf.d/zz-xdebug.ini
    done
fi

# Execute the supplied command
exec "$@"

