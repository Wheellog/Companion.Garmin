# this dockerfile is used to build an image for WheelLog.Garmin GitHub CI.

# Use Ubuntu 20.10 as a base image
FROM ubuntu:groovy

WORKDIR /sdk

RUN apt-get update && apt-get install make

RUN export PATH="sdk:$PATH"

COPY sdk sdk
