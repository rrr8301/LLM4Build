#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Activate the Python virtual environment
python3.11 -m venv venv
source venv/bin/activate

# Install project dependencies
pip install --upgrade pip
pip install -r requirements.txt

# Run tests using tox, ensuring all tests are executed
set +e
tox -e py3.11
EXIT_CODE=$?

# Exit with the test result code
exit $EXIT_CODE