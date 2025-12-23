#!/bin/bash

# Activate Python virtual environment
python3.12 -m venv .venv
source .venv/bin/activate

# Install project dependencies
python scripts/ci/install

# Run tests and ensure all tests are executed
set +e  # Do not exit immediately on error
python scripts/ci/run-tests --with-cov --with-xdist
TEST_EXIT_CODE=$?

# Placeholder for code coverage upload
echo "Code coverage upload step would go here."

# Exit with the test command's exit code
exit $TEST_EXIT_CODE