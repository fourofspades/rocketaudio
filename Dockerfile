FROM alpine:latest
LABEL maintainer "fourofspades"

RUN addgroup --system icecast && \
    adduser --system icecast
  
RUN apk add --update mailcap wget openssl ca-certificates \
		rm -rf /var/cache/apk/*

RUN 	cd /usr/bin/ && \
		wget -q https://www.rocketbroadcaster.com/streaming-audio-server/downloads/ubuntu-14.04/rsas-0.1.17-linux_amd64.tar.gz  -O /usr/bin/rsas.tar.gz && \
		tar -xvzf /usr/bin/rsas.tar.gz && \
		rm /usr/bin/rsas.tar.gz && \
		chmod +X /usr/bin/rsas && \
		ls -al

COPY docker-entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE 8000
VOLUME ["/var/log/icecast"]
ENTRYPOINT ["/entrypoint.sh"]
#CMD /usr/bin/rsas -c /etc/icecast.xml
CMD /bin/sh
