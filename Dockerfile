FROM fedora:29 AS builder

ARG DOWNLOAD=https://www.microchip.com/mymicrochip/filehandler.aspx?ddocname=en607660

RUN yum install -y wget
RUN cd /opt \
    && wget -O - ${DOWNLOAD} | tar xvzf - 

FROM fedora:29

ENV AVR_HOME /opt/avr8-gnu-toolchain-linux_x86_64
ENV PATH ${AVR_HOME}/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

COPY --from=builder /opt /opt

RUN yum install -y make cmake \
    && yum clean all
