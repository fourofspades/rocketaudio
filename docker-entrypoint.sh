#!/bin/sh

uname -a

if [ -n "$SOURCE_PASSWORD" ]; then
    sed -i "s/<password>[^<]*<\/password>/<password>$SOURCE_PASSWORD<\/password>/g" /etc/rsas.xml
fi
if [ -n "$SOURCE_USERNAME" ]; then
    sed -i "s/<username>[^<]*<\/username>/<username>$SOURCE_USERNAME<\/username>/g" /etc/rsas.xml
fi
if [ -n "$MAX_CLIENTS" ]; then
    sed -i "s/<clients>[^<]*<\/clients>/<clients>$MAX_CLIENTS<\/clients>/g" /etc/rsas.xml
fi

./usr/bin/rsas -b -c /etc/rsas.xml                                                                                                                   
                                                                                                                                                        
/app/liquidsoap $LIQUIDSOAP_SCRIPT  
exec "$@"
