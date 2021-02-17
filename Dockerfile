FROM ocaml/opam:debian-10 as builder

# Set correct environment variables
ENV DEBIAN_FRONTEND="noninteractive" HOME="/root" LC_ALL="C.UTF-8" LANG="en_US.UTF-8" LANGUAGE="en_US.UTF-8"
ENV supervisor_conf /etc/supervisor/supervisord.conf
ENV start_scripts_path /bin
ENV PACKAGES="taglib mad lame vorbis cry samplerate opus fdkaac faad flac liquidsoap"
ENV OPAMDEBUG=1

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
RUN opam install depext
RUN set -eux; \
    for package in $PACKAGES; do \
        opam depext --install $package; \
    done

RUN set -eux; \
    eval $(opam env); \
    mkdir -p /home/opam/root/app; \
    mv $(command -v liquidsoap) /home/opam/root/app; \
    opam depext --list $PACKAGES > /home/opam/root/app/depexts; \
    mkdir -p /home/opam/root/$OPAM_SWITCH_PREFIX/lib; \
    mv $OPAM_SWITCH_PREFIX/share /home/opam/root/$OPAM_SWITCH_PREFIX; \
    mv $OPAM_SWITCH_PREFIX/lib/liquidsoap /home/opam/root/$OPAM_SWITCH_PREFIX/lib

RUN sudo apt-get clean autoclean && \
    sudo apt-get autoremove --yes && \
    sudo rm -rf /var/lib/{apt,dpkg,cache,log}/

FROM phasecorex/user-debian:10-slim

COPY --from=builder /home/opam/root /

RUN set -eux; \
    sed -i 's/$/ non-free/' /etc/apt/sources.list; \
    apt-get update; \
    cat /app/depexts | xargs apt-get install -y --no-install-recommends; \
    rm -rf /var/lib/apt/lists/*; \
    /app/liquidsoap --version


EXPOSE 8000
VOLUME ["/var/log/icecast"]
ENTRYPOINT ["/entrypoint.sh"]
