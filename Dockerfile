FROM alpine:latest
LABEL maintainer "fourofspades"

RUN addgroup --system icecast && \
    adduser --system icecast
  
RUN apk add --update mailcap bash wget openssl ca-certificates \
		rm -rf /var/cache/apk/*

RUN 	mkdir /rsas && \
	cd /rsas && \
	wget -q https://www.rocketbroadcaster.com/streaming-audio-server/downloads/ubuntu-14.04/rsas-0.1.17-linux_amd64.tar.gz  -O /rsas/rsas.tar.gz && \
	tar -xvzf /rsas/rsas.tar.gz && \
	rm /rsas/rsas.tar.gz && \
	chmod +X /rsas/rsas

COPY docker-entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE 8000
VOLUME ["/var/log/icecast"]
ENTRYPOINT ["/entrypoint.sh"]
#CMD /usr/bin/rsas -c /etc/icecast.xml
CMD /bin/bash
