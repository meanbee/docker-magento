# Setup Magento cron
if [ "$ENABLE_CRON" = "true" ]; then
    echo "* * * * * root su www-data -s /bin/bash -c 'sh $MAGE_ROOT_DIR/cron.sh'" > /etc/cron.d/magento
    /etc/init.d/cron start
fi
