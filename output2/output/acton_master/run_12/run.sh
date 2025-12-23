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

# Build Acton with verbose output for debugging
retry make -j2 -C /app VERBOSE=1

# Run tests with verbose output for debugging
retry make -C /app test VERBOSE=1

# Check for specific test failures and log them
if [ $? -ne 0 ]; then
    echo "Some tests failed. Please check the logs for more details."
    exit 1
fi