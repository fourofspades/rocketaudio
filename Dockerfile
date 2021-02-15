FROM ubuntu:focal

# Set correct environment variables
ENV DEBIAN_FRONTEND="noninteractive" HOME="/root" LC_ALL="C.UTF-8" LANG="en_US.UTF-8" LANGUAGE="en_US.UTF-8"
ENV supervisor_conf /etc/supervisor/supervisord.conf
ENV start_scripts_path /bin


RUN addgroup --system icecast && \
    adduser --system icecast

# Update packages from baseimage
RUN apt-get update -qq
# Install and activate necessary software
RUN apt-get upgrade -qy && apt-get install -qy \
    apt-utils \
    wget  \
    ssl-cert \
    openssl \
    unzip \
    sudo

RUN rm -rf /var/apt-cache/*

RUN 	mkdir /rsas && \
	cd /rsas && \
	wget -q https://www.rocketbroadcaster.com/streaming-audio-server/downloads/ubuntu-14.04/rsas-0.1.17-linux_amd64.tar.gz  -O /rsas/rsas.tar.gz && \
	tar -xvzf /rsas/rsas.tar.gz && \
	rm /rsas/rsas.tar.gz && \
	chmod +X /rsas/rsas

COPY icecast.xml /etc/icecast.xml
COPY docker-entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE 8000
VOLUME ["/var/log/icecast"]
ENTRYPOINT ["/entrypoint.sh"]
CMD /rsas/rsas -c /etc/icecast.xml
#CMD /bin/bash
