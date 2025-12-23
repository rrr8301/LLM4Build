#!/bin/bash

set -e

# Activate Rust environment
source $HOME/.cargo/env

# Update system package info
apt-get update

# Install system dependencies
apt-get install -y \
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
    libpcre2-dev \
    libsnappy-dev \
    libsodium-dev \
    libssl-dev \
    libtool \
    libxxhash-dev \
    libzstd-dev \
    ninja-build \
    python3-setuptools \
    xxhash \
    zlib1g-dev \
    zstd

# Install system dependencies using getdeps.py
python3 build/fbcode_builder/getdeps.py --allow-system-packages install-system-deps --recursive watchman
python3 build/fbcode_builder/getdeps.py --allow-system-packages install-system-deps --recursive patchelf

# Query paths (output is ignored in this script)
python3 build/fbcode_builder/getdeps.py --allow-system-packages query-paths --recursive --src-dir=. watchman

# Build Watchman
python3 build/fbcode_builder/getdeps.py --allow-system-packages build --src-dir=. watchman --project-install-prefix watchman:/usr/local

# Copy artifacts
python3 build/fbcode_builder/getdeps.py --allow-system-packages fixup-dyn-deps --strip --src-dir=. watchman _artifacts/linux --project-install-prefix watchman:/usr/local --final-install-prefix /usr/local

# Test Watchman
set +e  # Ensure all tests run even if some fail
python3 build/fbcode_builder/getdeps.py --allow-system-packages test --src-dir=. watchman --project-install-prefix watchman:/usr/local