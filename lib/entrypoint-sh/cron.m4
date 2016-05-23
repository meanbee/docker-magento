# Setup Magento cron
echo "* * * * * root su www-data -s /bin/bash -c 'sh $MAGE_ROOT_DIR/cron.sh'" > /etc/cron.d/magento
