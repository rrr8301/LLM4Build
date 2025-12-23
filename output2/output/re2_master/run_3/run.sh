#!/bin/bash

# Activate environments if needed (none specified)

# Ensure vcpkg is up to date and install dependencies
cd /vcpkg
./vcpkg update
./vcpkg install abseil gtest benchmark

# Run make and make test, ensuring all tests are executed
set -e
cd /app
make || true
make test || true