FROM debian:9-slim AS builder

ARG DOWNLOAD=https://www.microchip.com/mymicrochip/filehandler.aspx?ddocname=en607660

RUN apt-get update
RUN apt-get install -y wget
RUN cd /opt \
    && wget -O - ${DOWNLOAD} | tar xvzf - 

FROM debian:9-slim

ENV AVR_HOME /opt/avr8-gnu-toolchain-linux_x86_64
ENV PATH ${AVR_HOME}/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

COPY --from=builder /opt /opt

RUN  apt-get update \
    && apt-get -y install make cmake \
    && rm -rf /var/lib/apt/lists/*