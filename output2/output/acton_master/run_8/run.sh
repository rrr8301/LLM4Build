#!/bin/bash

# Source ghcup environment
source /root/.ghcup/env

# Ensure network is available and retry if necessary
function retry {
    local n=1
    local max=5
    local delay=5
    while true; do
        "$@" && break || {
            if [[ $n -lt $max ]]; then
                ((n++))
                echo "Command failed. Attempt $n/$max:"
                sleep $delay;
            else
                echo "The command has failed after $n attempts."
                return 1
            fi
        }
    done
}

# Build Acton
retry make -j2 -C /app

# Run tests
retry make -C /app test