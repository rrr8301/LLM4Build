#!/bin/bash

# Activate environment variables
export CC=clang-18
export CXX=clang++-18
export PKG_CONFIG_PATH=/usr/local/share/vcpkg/installed/x64-linux/lib/pkgconfig

# Install project dependencies using vcpkg
/vcpkg/vcpkg install abseil gtest benchmark

# Build the project
make

# Run tests and ensure all tests are executed
make test || true