FROM ubuntu:focal

# Set correct environment variables
ENV DEBIAN_FRONTEND="noninteractive" HOME="/root" LC_ALL="C.UTF-8" LANG="en_US.UTF-8" LANGUAGE="en_US.UTF-8"
ENV supervisor_conf /etc/supervisor/supervisord.conf
ENV start_scripts_path /bin

COPY icecast.xml /etc/icecast.xml
COPY docker-entrypoint.sh /entrypoint.sh

RUN addgroup --system icecast && \
    adduser --system icecast  && \
    apt-get update -qq  && \
    apt-get upgrade -qy && apt-get install -qy \
    apt-utils \
    wget  \
    iputils-ping \
    net-tools \
    ssl-cert \
    openssl \
    libogg0  && \
    cd /tmp && \
    wget -q https://www.rocketbroadcaster.com/streaming-audio-server/downloads/ubuntu-20.04/rsas_0.1.17-1_amd64.deb -O /tmp/rsas.deb && \
    dpkg -i /tmp/rsas.deb && \
    rm /tmp/rsas.deb  && \
    chmod +x /entrypoint.sh && \ 
    apt-get clean autoclean && \
    apt-get autoremove --yes && \
    rm -rf /var/lib/{apt,dpkg,cache,log}/

EXPOSE 8000
VOLUME ["/var/log/icecast"]
ENTRYPOINT ["/entrypoint.sh"]
CMD ./usr/bin/rsas -c /etc/icecast.xml
