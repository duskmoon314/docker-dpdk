ARG BASE_IMG=ubuntu:22.04
FROM ${BASE_IMG}
LABEL MAINTAINER="duskmoon <kp.campbell.he@duskmoon314.com>"

ARG DESKTOP_MACHINE=no

ARG DPDK_VERSION=22.07 \
    # Only used for installing Pcap++ \
    PCAPPP_VERSION=22.07

ARG SCRIPT=apply-dpdk.sh

COPY scripts /tmp/

RUN /bin/bash "tmp/${SCRIPT}" \
    && apt clean autoclean \
    && apt autoremove --purge -y \
    && rm -rf /var/lib/apt/lists/* /tmp/*

WORKDIR /home/app

ENV RTE_SDK=/home/dpdk RTE_TARGET=x86_64-native-linuxapp-gcc