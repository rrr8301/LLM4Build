#!/bin/bash

# Activate environment variables
export CC=/usr/bin/clang-18
export CXX=/usr/bin/clang++-18
export VCPKG_ROOT=/vcpkg
export VCPKG_DEFAULT_TRIPLET=x64-linux
export PKG_CONFIG_PATH=/vcpkg/installed/x64-linux/lib/pkgconfig

# Build the project
make

# Run tests and ensure all tests are executed
make test || true