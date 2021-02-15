FROM alpine:latest
LABEL maintainer "fourofspades"

RUN addgroup --system icecast && \
    adduser --system icecast
  
RUN apk add --update mailcap curl openssl ca-certificates \
		rm -rf /var/cache/apk/*

RUN 	cd /usr/bin/ && \
		curl https://www.rocketbroadcaster.com/streaming-audio-server/downloads/ubuntu-14.04/rsas-0.1.17-linux_amd64.tar.gz  | /usr/bin/rsas.tar.gz -- --quiet && \
		tar -xvzf /usr/bin/rsas.tar.gz && \
		rm /usr/bin/rsas.tar.gz

COPY docker-entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE 8000
VOLUME ["/var/log/icecast"]
ENTRYPOINT ["/entrypoint.sh"]
CMD rsas -c /etc/icecast.xml
