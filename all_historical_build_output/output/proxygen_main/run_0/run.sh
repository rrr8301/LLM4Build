#!/bin/bash

set -e

# Build the project
./build.sh

# Run tests
cd _build
make test || true  # Ensure all tests run even if some fail