docker system prune
docker build -t mgillespie/liquidsoap_icecast_kh:v2.2.0 -f- . < Dockerfile
docker run --rm -it --entrypoint=/bin/bash mgillespie/liquidsoap_icecast_kh:v2.2.0

docker build -t mgillespie/liquidsoap_icecast_kh:latest -f- . < Dockerfile
docker run --rm -it --entrypoint=/bin/bash mgillespie/liquidsoap_icecast_kh:latest
