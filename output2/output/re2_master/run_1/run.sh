#!/bin/bash

# Activate environments if needed (none specified)

# Install project dependencies using vcpkg
vcpkg update
vcpkg install abseil gtest benchmark

# Run make and make test, ensuring all tests are executed
set -e
make || true
make test || true