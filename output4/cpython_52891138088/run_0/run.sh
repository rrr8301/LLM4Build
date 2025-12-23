#!/bin/bash

# Activate environments (if any)

# Install project dependencies
# Assuming posix-deps-apt.sh installs necessary dependencies
sudo ./.github/workflows/posix-deps-apt.sh

# Build CPython
make -j

# Run tests
set -e
xvfb-run make ci || true