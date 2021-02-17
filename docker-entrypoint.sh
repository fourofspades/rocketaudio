#!/bin/sh

uname -a

if [ -n "$SOURCE_PASSWORD" ]; then
    sed -i "s/<password>[^<]*<\/password>/<password>$ICECAST_SOURCE_PASSWORD<\/password>/g" /etc/rsas.xml
fi
if [ -n "$SOURCE_USERNAME" ]; then
    sed -i "s/<username>[^<]*<\/username>/<username>$ICECAST_SOURCE_PASSWORD<\/username>/g" /etc/rsas.xml
fi
if [ -n "$MAX_SOURCES" ]; then
    sed -i "s/<sources>[^<]*<\/sources>/<sources>$ICECAST_MAX_SOURCES<\/sources>/g" /etc/rsas.xml
fi

./usr/bin/rsas -b -c /etc/rsas.xml                                                                                                                   
                                                                                                                                                        
/app/liquidsoap $LIQUIDSOAP_SCRIPT  
exec "$@"
