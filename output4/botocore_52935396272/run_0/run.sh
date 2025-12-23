#!/bin/bash

# Activate virtual environment if needed
# source .venv/bin/activate

# Install project dependencies
python3.13 scripts/ci/install

# Run tests and ensure all tests are executed
set +e  # Do not exit immediately on error
python3.13 scripts/ci/run-tests --with-cov --with-xdist
set -e  # Re-enable exit on error