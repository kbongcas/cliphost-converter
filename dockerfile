FROM ubuntu:22.04
ARG DEBIAN_FRONTEND=noninteractive

RUN mkdir /clips
RUN mkdir /converted

RUN apt -y update && \
    apt -y upgrade && \
    apt -y install ffmpeg &&\
    apt -y install curl

COPY clipconverter-converter.sh clipconverter-converter.sh