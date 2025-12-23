#!/bin/bash

# Activate environments if any (none specified)

# Install project dependencies if any (none specified)

# Build the project
./scripts/build-local.sh

# Run tests
cd build/local
ctest --output-on-failure --parallel $(nproc) || true

# Ensure all tests are executed, even if some fail
exit 0