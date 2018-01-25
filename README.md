# Prometheus for Raspberry Pi

This is a build of Prometheus 2 for the Raspberry Pi.

Docker images for this build can be found here [https://hub.docker.com/r/evns/rpi-prometheus](https://hub.docker.com/r/evns/rpi-prometheus)

The source can be found here: [https://github.com/evnsio/rpi-prometheus](https://github.com/evnsio/rpi-prometheus)

## Build details

I'm building the code from source in a multi-stage Docker build.  I've tried to keep the structure of the resulting image similar to the [Dockerfile](https://github.com/prometheus/prometheus/blob/master/Dockerfile) in the Prometheus Repo.

I had issues getting the build to work due to the `promu` make target not accounting for arm64 architecture.  This is a known issue, tracked [here](https://github.com/prometheus/prometheus/issues/3460). To workaround I've grabbed the promu binary separately, added it to the image through Docker build step, and removed the call to promu from the build target.


## Usage

As the image is similar in structure, you can follow the [Installation Instructions](https://prometheus.io/docs/prometheus/latest/installation/#volumes-bind-mount) provided by Prometheus.

The simplest way to run with your own config is to mount it into the container alongside the `prometheus` binary:

```
docker run -d -p 9090:9090 \
           -v /path/to/prometheus.yml:/bin/prometheus.yml \
           evns/rpi-prometheus:v2.1.0
```

Alternatively, mount wherever you like and pass in the args:

```
docker run -d -p 9090:9090 \
           -v /path/to/prometheus.yml:/prometheus-data/prometheus.yml \
           evns/rpi-prometheus --config.file=/prometheus-data/prometheus.yml
```