#!/bin/bash

# Activate virtual environment
python3 -m venv .venv
source .venv/bin/activate

# Install project dependencies and CRT
python scripts/ci/install --extras crt

# Run tests with coverage and xdist, ensuring all tests run
set +e  # Do not exit immediately on error
python scripts/ci/run-crt-tests --with-cov --with-xdist
set -e  # Re-enable exit on error