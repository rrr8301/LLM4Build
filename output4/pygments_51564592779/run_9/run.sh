#!/bin/bash

# Activate the virtual environment
source venv/bin/activate

# Ensure all dependencies are installed
pip install -r requirements.txt

# Ensure that pytest and any other necessary plugins are installed
pip install pytest pytest-cov pytest-randomly

# Run tests with tox, ensuring all tests are executed
set +e  # Do not exit immediately on failure

# Run tox
tox --recreate --skip-missing-interpreters false
exit_code=$?

# Exit with the test result code
exit $exit_code