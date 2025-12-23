#!/bin/bash

# Activate the virtual environment
source venv/bin/activate

# Ensure tox is installed in the virtual environment
pip install --upgrade tox

# Run tests with tox, ensuring all tests are executed
set +e  # Do not exit immediately on failure
tox
EXIT_CODE=$?

# Exit with the test command's exit code
exit $EXIT_CODE