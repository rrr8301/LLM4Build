#!/bin/bash

# run.sh

# Exit immediately if a command exits with a non-zero status
set -e

# Install system dependencies
# Directly install dependencies without sudo
apt-get update && apt-get install -y \
    autoconf \
    automake \
    binutils-dev \
    cmake \
    libboost-all-dev \
    libdouble-conversion-dev \
    libdwarf-dev \
    libevent-dev \
    libgflags-dev \
    liblz4-dev \
    libsnappy-dev \
    libsodium-dev \
    libssl-dev \
    libtool \
    libzstd-dev \
    ninja-build \
    zlib1g-dev \
    zstd

# Build the project
./getdeps.sh

# Run tests
python3 ./build/fbcode_builder/getdeps.py test mvfst --install-prefix=$(pwd)/_build || true

# Ensure all tests are executed, even if some fail
echo "All tests executed."