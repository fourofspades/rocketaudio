docker system prune
docker build -t mgillespie/liquidsoap_icecast_kh:v2.1.3 -f- . < Dockerfile
docker run --rm -it --entrypoint=/bin/bash mgillespie/liquidsoap_icecast_kh:v2.1.3

docker build -t mgillespie/liquidsoap_icecast_kh:latest -f- . < Dockerfile
docker run --rm -it --entrypoint=/bin/bash mgillespie/liquidsoap_icecast_kh:latest
