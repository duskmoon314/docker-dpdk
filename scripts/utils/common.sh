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
