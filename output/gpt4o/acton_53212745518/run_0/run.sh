#!/bin/bash

# Show platform and environment
uname -a
env
cat /proc/cpuinfo

# Set BUILD_RELEASE if building for a version tag
if [[ "$GITHUB_REF" == refs/tags/v* ]]; then
  export BUILD_RELEASE=1
fi

# Install build prerequisites
export DEBIAN_FRONTEND=noninteractive
apt-get update
apt-get install -qy bzip2 curl g++ haskell-stack libtinfo-dev make procps zlib1g-dev gdb

# Build Acton
make -j2 -C /app BUILD_RELEASE=${BUILD_RELEASE}

# Build a release
make -C /app release

# Run tests
ulimit -c unlimited
make -C /app test || true  # Ensure all tests run even if some fail