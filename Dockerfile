FROM phasecorex/liquidsoap:latest as builder

# Set correct environment variables
ENV DEBIAN_FRONTEND="noninteractive" HOME="/root" LC_ALL="C.UTF-8" LANG="en_US.UTF-8" LANGUAGE="en_US.UTF-8"
ENV supervisor_conf /etc/supervisor/supervisord.conf
ENV start_scripts_path /bin

ARG SOURCE_PASSWORD=hackmebadly
ARG SOURCE_USERNAME=source
ARG MAX_CLIENTS=20
ARG LIQUIDSOAP_SCRIPT=/myscript.liq

COPY rsas.xml /etc/rsas.xml
COPY docker-entrypoint.sh /entrypoint.sh

#RocketAudioServer
RUN addgroup --system icecast && \
    adduser --system icecast  && \
    sed -i 's/$/ non-free/' /etc/apt/sources.list; \
    apt-get update -qq  && \
    apt-get upgrade -qy && \
    apt-get install -qy \
    apt-utils \
    procps \
    nano \
    icecast \
    wget  \
    iputils-ping \
    net-tools \
    ssl-cert \
    openssl \
    libogg0  && \
    cd /tmp && \
    wget -q https://www.rocketbroadcaster.com/streaming-audio-server/downloads/debian10/rsas_0.1.17-1_amd64.deb -O /tmp/rsas.deb && \
    dpkg -i /tmp/rsas.deb && \
    rm /tmp/rsas.deb  && \
    chmod +x /entrypoint.sh

EXPOSE 8000
VOLUME ["/var/log/rsas"]
ENTRYPOINT ["/entrypoint.sh"]
