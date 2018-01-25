#!/bin/bash

# Don't accidentally build on a non arm architecture
ARCH=`uname -m`
if [ "$ARCH" != "armv7l" ]; then
  echo "Only run this on an Arm processor!"
  exit 1
fi

# The docker build pulls from master so the versions should align
VERSION=`curl -s https://raw.githubusercontent.com/prometheus/prometheus/master/VERSION`

# Build, tag and push the Docker image
docker build -t evns/rpi-prometheus:v${VERSION} .
docker push evns/rpi-prometheus:v${VERSION}
