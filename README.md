# RocketAudio
RocketAudio for Docker with LiquidSoap
```
docker run -d -p 8000:8000 fourofspades/rocketaudio
```

Uses Icecast compatability mode to set enviroment variables from the docker container.

Supported RSAS ENV variables:

```
ICECAST_SOURCE_PASSWORD, ICECAST_ADMIN_PASSWORD, ICECAST_RELAY_PASSWORD
ICECAST_ADMIN_USERNAME, ICECAST_ADMIN_EMAIL
ICECAST_LOCATION, ICECAST_HOSTNAME
ICECAST_MAX_CLIENTS, ICECAST_MAX_SOURCES
LIQUIDSOAP_SCRIPT
```

Supported LiquidSoap variables:

```
LIQUIDSOAP_SCRIPT
```
