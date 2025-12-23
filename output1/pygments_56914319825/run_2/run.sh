#!/bin/bash

# Install project in development mode
pip install -e .

# Ensure test files are discoverable by adding tests directory to PYTHONPATH
export PYTHONPATH=/app:/app/tests

# Run tests with tox, ensuring all tests run even if some fail
# The -W error flag makes warnings into errors as per the original workflow
# Explicitly specify test directory for pytest
set +e
tox -- -W error --rootdir=/app tests
EXIT_CODE=$?
set -e

# Exit with the test result code
exit $EXIT_CODE