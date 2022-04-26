FROM savonet/liquidsoap:v2.0.4 as builder

# Set correct environment variables
ENV DEBIAN_FRONTEND="noninteractive" HOME="/root" LC_ALL="C.UTF-8" LANG="en_US.UTF-8" LANGUAGE="en_US.UTF-8"
ENV supervisor_conf /etc/supervisor/supervisord.conf
ENV start_scripts_path /bin


ENV MAX_CLIENTS=20
ENV LIQUIDSOAP_SCRIPT=/myscript.liq
ENV ICECAST_SOURCE_PASSWORD=hackmebadly
ENV ICECAST_ADMIN_PASSWORD=hackmebadly
ENV ICECAST_ADMIN_USERNAME=bigusdickus
ENV ICECAST_RELAY_PASSWORD=hackmebadly
ENV ICECAST_ADMIN_EMAIL=icemaster@uranus
ENV ICECAST_LOCATION=Uranus
ENV ICECAST_HOSTNAME=localhost
ENV ICECAST_MAX_SOURCES=2
ENV ICECAST_BURST_SIZE=65535

USER root
COPY docker_etc/ /etc/
COPY docker_usr/ /usr/
COPY docker-entrypoint.sh /entrypoint.sh

#Icecast and Icecast-kh  (usr/bin and usr/local/bin)
RUN addgroup --system icecast && \
    adduser --system icecast  && \
    sed -i 's/$/ non-free/' /etc/apt/sources.list; \
    apt-get update -qq  && \
    apt-get upgrade -qy && \
    apt-get install -qy \
    apt-utils \
    procps \
    nano \
	libcurl4 \
    icecast2 \
    wget  \
    iputils-ping \
    net-tools \
    ssl-cert \
    openssl \
    libogg0  && \
	mkdir -p /var/log/icecast2 && \
    chmod +x /entrypoint.sh && \
	chmod +x /usr/local/bin/icecast && \
	chown icecast:icecast /var/log/icecast2/ 

EXPOSE 8000
VOLUME ["/var/log/icecast2"]
ENTRYPOINT ["/entrypoint.sh"]
