#!/bin/bash

set -exuo pipefail

# Source common functions with funky bash, as per: https://stackoverflow.com/a/12694189
DIR="${BASH_SOURCE%/*}"
test -d "$DIR" || DIR=$PWD
# shellcheck source=utils/common.sh
. "$DIR/utils/common.sh"

# tmp space for building
: "${TEMP_DIR:=/tmp}"

# Exec apply-dpdk.sh
/bin/bash "/tmp/apply-dpdk.sh"

# Install Dependencies
apt install -y --no-install-recommends \
    libpcap-dev \
    libstdc++6
# end of list

# Download PcapPlusPlus
: "${PCAPPP_VERSION:=22.11}"

mkdir "/home/PcapPlusPlus"
wget -q -O "$TEMP_DIR/PcapPlusPlus.tar.gz" "https://github.com/seladb/PcapPlusPlus/archive/v$PCAPPP_VERSION.tar.gz"
tar -xzf "$TEMP_DIR/PcapPlusPlus.tar.gz" -C "/home/PcapPlusPlus" --strip-components=1
cd "/home/PcapPlusPlus"
./configure-linux.sh --dpdk --dpdk-home "/home/dpdk"
make libs -j"$(nproc)"
make install
