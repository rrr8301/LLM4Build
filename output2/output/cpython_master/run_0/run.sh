#!/bin/bash

set -e

# Activate Python environment
python3.11 -m venv venv
source venv/bin/activate

# Configure CPython
./configure --with-pydebug

# Build CPython
make -j4

# Run tests
make test || true  # Ensure all tests run even if some fail