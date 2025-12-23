#!/bin/bash

set -e

# Activate vcpkg environment
export VCPKG_ROOT=/opt/vcpkg
export PATH=$VCPKG_ROOT:$PATH

# Build and test the project
make
make test  # Ensure all tests run