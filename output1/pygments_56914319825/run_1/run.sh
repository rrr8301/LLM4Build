#!/bin/bash

# Install project in development mode
pip install -e .

# Ensure test files are discoverable
export PYTHONPATH=/app

# Run tests with tox, ensuring all tests run even if some fail
# The -W error flag makes warnings into errors as per the original workflow
set +e
tox -- -W error --rootdir=/app
EXIT_CODE=$?
set -e

# Exit with the test result code
exit $EXIT_CODE