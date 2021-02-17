FROM ocaml/opam:debian-10 as builder

# Set correct environment variables
ENV DEBIAN_FRONTEND="noninteractive" HOME="/root" LC_ALL="C.UTF-8" LANG="en_US.UTF-8" LANGUAGE="en_US.UTF-8"
ENV supervisor_conf /etc/supervisor/supervisord.conf
ENV start_scripts_path /bin

COPY icecast.xml /etc/icecast.xml
COPY docker-entrypoint.sh /entrypoint.sh

#RocketAudioServer
RUN sudo addgroup --system icecast && \
    sudo adduser --system icecast  && \
    sudo sed -i 's/$/ non-free/' /etc/apt/sources.list; \
    sudo apt-get update -qq  && \
    sudo apt-get upgrade -qy && \
    sudo apt-get install -qy \
    apt-utils \
    wget  \
    iputils-ping \
    net-tools \
    ssl-cert \
    openssl \
    libogg0  && \
    cd /tmp && \
    sudo wget -q https://www.rocketbroadcaster.com/streaming-audio-server/downloads/ubuntu-20.04/rsas_0.1.17-1_amd64.deb -O /tmp/rsas.deb && \
    sudo dpkg -i /tmp/rsas.deb && \
    sudo rm /tmp/rsas.deb  && \
    sudo chmod +x /entrypoint.sh

#LiquidSoap
FROM ocaml/opam:latest
LABEL maintainer "infiniteproject@gmail.com"

ENV PACKAGES="taglib mad lame vorbis cry samplerate opus fdkaac faad flac liquidsoap"
ENV OPAMDEBUG=1

RUN opam depext $PACKAGES && \
    opam install $PACKAGES

RUN sudo apt-get clean && \
    sudo rm -fr /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY docker-entrypoint.sh /entrypoint.sh
RUN sudo chmod +x /entrypoint.sh


EXPOSE 8000
VOLUME ["/var/log/icecast"]
ENTRYPOINT ["/entrypoint.sh"]
