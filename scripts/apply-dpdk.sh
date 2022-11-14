#!/bin/bash

set -exuo pipefail

# Source common functions with funky bash, as per: https://stackoverflow.com/a/12694189
DIR="${BASH_SOURCE%/*}"
test -d "$DIR" || DIR=$PWD
# shellcheck source=utils/common.sh
. "$DIR/utils/common.sh"

# tmp space for building
: "${TEMP_DIR:=/tmp}"

# Install Dependencies
apt update -q
apt install -y --no-install-recommends \
    build-essential \
    gcc-multilib \
    kmod \
    libnuma-dev \
    linux-headers-generic \
    iproute2 \
    meson \
    ninja-build \
    pciutils \
    pkgconf \
    python-is-python3 \
    python3-pip \
    python3-pyelftools \
    wget
# end of list

# Download DPDK
: "${DPDK_VERSION:=22.07}"

mkdir "/home/dpdk"
wget -q -O "$TEMP_DIR/dpdk.tar.xz" "https://fast.dpdk.org/rel/dpdk-$DPDK_VERSION.tar.xz"
tar -xJf "$TEMP_DIR/dpdk.tar.xz" -C "/home/dpdk" --strip-components=1
cd "/home/dpdk"
if contains "17.11.10 18.11.11" $DPDK_VERSION; then
    echo "Building Older DPDK with MAKE"
    make config T=x86_64-native-linuxapp-gcc
    make -j"$(nproc)"
    make install
else
    echo "Building DPDK with MESON"
    meson build
    ninja -C build
    ninja -C build install
    ldconfig
fi
