#!/bin/bash

set -exuo pipefail

# Set up the environment

: "${DEBIAN_FRONTEND:=noninteractive}"
export DEBIAN_FRONTEND

# Utility functions

command_exists() {
    command -v "$@" >/dev/null 2>&1
}

contains() {
    [[ $1 =~ (^|[[:space:]])$2($|[[:space:]]) ]] && return 0 || return 1
}

# https://stackoverflow.com/a/4024263/15766817
version_lte() {
    printf '%s\n%s' "$1" "$2" | sort -C -V
}

version_lt() {
    ! version_lte "$2" "$1"
}
