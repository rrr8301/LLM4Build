#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Activate the virtual environment
source venv/bin/activate

# Install project dependencies
pip install --no-cache-dir .

# Run all tests, ensuring all tests are executed even if some fail
set +e

# Check if the tests directory exists and is not empty
if [ -d "tests" ] && [ "$(ls -A tests)" ]; then
    python3 -m unittest discover -s tests
else
    echo "No tests found in the 'tests' directory."
    exit 1
fi

TEST_EXIT_CODE=$?

# Exit with the test command's exit code
exit $TEST_EXIT_CODE