# Configure Xdebug
if [ "$XDEBUG_CONFIG" ]; then
    echo "" > /usr/local/etc/php/conf.d/zz-xdebug.ini
    for config in $XDEBUG_CONFIG; do
        echo "xdebug.$config" >> /usr/local/etc/php/conf.d/zz-xdebug.ini
    done
fi
