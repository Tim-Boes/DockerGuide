FROM ubuntu:22.04

WORKDIR /home/

COPY ./ .

RUN apt update && \
    apt install -y vim && \
    apt install -y python3.10 && \
    apt install -y neofetch 
