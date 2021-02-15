FROM alpine:latest
LABEL maintainer "fourofspades"

RUN addgroup --system icecast && \
    adduser --system icecast
  
RUN apk add --update \
        mailcap && \
		wget && \
    rm -rf /var/cache/apk/*
RUN cd /usr/bin 
RUN wget -q https://www.rocketbroadcaster.com/streaming-audio-server/downloads/ubuntu-14.04/rsas-0.1.17-linux_amd64.tar.gz
RUN tar -xvzf rsas-0.1.17-linux_amd64.tar.gz
RUN rm rsas-0.1.17-linux_amd64.tar.gz

COPY docker-entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE 8000
VOLUME ["/var/log/icecast"]
ENTRYPOINT ["/entrypoint.sh"]
CMD rsas -c /etc/icecast.xml
