# RocketAudio
RocketAudio for Docker with LiquidSoap
```
docker run -d -p 8000:8000 fourofspades/rocketaudio
```

Uses Icecast compatability mode to set enviroment variables from the docker container.

Supported RSAS ENV variables:
(Required)
```
SOURCE_PASSWORD, SOURCE_USERNAME,MAX_CLIENTS

```
Supported LiquidSoap variables:
(Required)
```
LIQUIDSOAP_SCRIPT
```
