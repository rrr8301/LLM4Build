#!/bin/bash

# run.sh

# Activate the virtual environment
source .venv/bin/activate

# Install project dependencies
pip install -r requirements.txt

# Run tests and ensure all tests are executed
set +e  # Do not exit immediately on error
python scripts/ci/run-tests --with-cov --with-xdist
TEST_EXIT_CODE=$?

# Placeholder for code coverage reporting
echo "Code coverage reporting is not supported in this script."

# Exit with the test exit code
exit $TEST_EXIT_CODE