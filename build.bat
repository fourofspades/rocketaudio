docker system prune
docker build -t mgillespie/rocketaudio:testing2 -f- . < Dockerfile
docker run --rm -it --entrypoint=/bin/bash mgillespie/rocketaudio:testing2
