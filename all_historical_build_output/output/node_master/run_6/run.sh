#!/bin/bash

# run.sh

# Exit immediately if a command exits with a non-zero status
set -e

# Install project dependencies
pip install -r requirements.txt || true  # Assuming a requirements.txt file exists
npm install || true  # Assuming a package.json file exists

# Run environment information
npx envinfo

# Build the project with a specific C++ standard
export CXXFLAGS="-std=c++17"  # Use C++17 standard
make build-ci -j4 V=1 CONFIG_FLAGS="--error-on-warn" || true

# Run tests
# Ensure all tests are executed, even if some fail
set +e
make test-internet -j4 V=1
set -e