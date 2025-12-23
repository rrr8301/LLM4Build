#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Activate virtual environment if needed
# source .venv/bin/activate

# Install project dependencies
python -m pip install --no-cache-dir -r requirements.txt

# Run tests
set +e  # Continue on errors
python scripts/ci/run-tests --with-cov --with-xdist
TEST_EXIT_CODE=$?

# Run Codecov (assuming codecov bash uploader is available)
# curl -s https://codecov.io/bash | bash -s -- -t <your_codecov_token>

exit $TEST_EXIT_CODE