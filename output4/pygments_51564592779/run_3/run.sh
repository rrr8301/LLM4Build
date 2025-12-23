#!/bin/bash

# Activate the virtual environment
source venv/bin/activate

# Ensure all dependencies are installed
pip install -r requirements.txt

# Run tests with tox, ensuring all tests are executed
set +e  # Do not exit immediately on failure

# Ensure that pytest is installed
pip install pytest

# Run tox
tox
exit_code=$?

# Exit with the test result code
exit $exit_code