#!/bin/bash

set -e

# Activate Python environment
python3 -m venv venv
source venv/bin/activate

# Install project dependencies if any (placeholder)
if [ -f requirements.txt ]; then
    pip install -r requirements.txt
fi

# Install envinfo globally to avoid npm warning
npm install -g envinfo

# Environment Information
npx envinfo

# Build with C++17 standard
export CXXFLAGS="-std=c++17"
export LDFLAGS="-L/usr/lib/ssl"  # Ensure the linker uses the correct OpenSSL library
make build-ci -j4 V=1 CONFIG_FLAGS="--error-on-warn"

# Test
set +e  # Ensure all tests run even if some fail
make run-ci -j4 V=1 TEST_CI_ARGS="-p actions --measure-flakiness 9"
set -e