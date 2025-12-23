#!/bin/bash

set -e

# Remove sudo from all Python scripts in the build/fbcode_builder directory
find build/fbcode_builder -name "*.py" -exec sed -i 's/\bsudo\b//g' {} +

# Ensure that the environment variable is set to avoid permission issues
export GETDEPS_CMAKE_DEFINES=""

# Install system dependencies using getdeps.py without sudo
# Directly run the apt-get install command as we have root permissions in the container
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

# Fetch and build dependencies
python3 build/fbcode_builder/getdeps.py --allow-system-packages fetch --no-tests ninja
python3 build/fbcode_builder/getdeps.py --allow-system-packages build --no-tests ninja

python3 build/fbcode_builder/getdeps.py --allow-system-packages fetch --no-tests cmake
python3 build/fbcode_builder/getdeps.py --allow-system-packages build --no-tests cmake

# Add more fetch and build steps as needed for other dependencies

# Build proxygen
python3 build/fbcode_builder/getdeps.py --allow-system-packages build --src-dir=. proxygen --project-install-prefix proxygen:/usr/local

# Increase timeout for tests to avoid timeout failures
export CTEST_OUTPUT_ON_FAILURE=1
export CTEST_PARALLEL_LEVEL=4  # Reduce parallelism to avoid resource exhaustion

# Test proxygen
python3 build/fbcode_builder/getdeps.py --allow-system-packages test --src-dir=. proxygen --project-install-prefix proxygen:/usr/local