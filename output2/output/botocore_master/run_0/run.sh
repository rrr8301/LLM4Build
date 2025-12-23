#!/bin/bash

# Activate virtual environment if needed
# source .venv/bin/activate

# Install project dependencies
python scripts/ci/install

# Run tests and ensure all tests are executed
set +e  # Do not exit immediately on error
python scripts/ci/run-tests --with-cov --with-xdist
EXIT_CODE=$?

# Exit with the test command's exit code
exit $EXIT_CODE