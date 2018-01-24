#!/bin/bash
docker build -t evns/rpi-prometheus:v2.1.0 .
docker push evns/rpi-prometheus:v2.1.0
