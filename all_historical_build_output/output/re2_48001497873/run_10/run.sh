#!/bin/bash

set -e

# Activate vcpkg environment
export VCPKG_ROOT=/opt/vcpkg
export PATH=$VCPKG_ROOT:$PATH

# Ensure PKG_CONFIG_PATH is set correctly
export PKG_CONFIG_PATH=/opt/vcpkg/installed/x64-linux/lib/pkgconfig

# Build and test the project
make
make test  # Ensure all tests run