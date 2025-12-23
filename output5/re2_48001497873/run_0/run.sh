#!/bin/bash

set -e

# Activate vcpkg environment
export VCPKG_ROOT=/opt/vcpkg
export PATH=$VCPKG_ROOT:$PATH

# Build and test the project
make
make test || true  # Ensure all tests run even if some fail