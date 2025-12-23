#!/bin/bash

# Activate the virtual environment
source .venv/bin/activate

# Install project dependencies
python scripts/ci/install

# Run tests and ensure all tests are executed
set +e  # Do not exit immediately on error
python scripts/ci/run-tests --with-cov --with-xdist
set -e  # Re-enable exit on error