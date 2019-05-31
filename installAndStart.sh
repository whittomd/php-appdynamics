#!/bin/sh

if [ -n "$APPD_ENABLE" -a "$APPD_ENABLE" = '1' ]; then
    echo "INSTALLING APPDYNAMICS AGENT"
    /opt/appdynamics-php-agent-linux_x64/install.sh  --enable-cli -s -a=$APPD_ACCOUNTNAME@$APPD_ACCOUNTKEY $APPD_CONTROLLER $APPD_PORT $APPD_APP $APPD_TIER $APPD_NODE
    echo "VERIFYING CONNECTIVITY TO CONTROLLER"
    curl -k -v https://$APPD_CONTROLLER:$APPD_PORT
    php -r "echo 'test';"
fi
php-fpm