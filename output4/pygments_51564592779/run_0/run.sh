#!/bin/bash

# Activate the virtual environment
source venv/bin/activate

# Install project dependencies
pip install -r requirements.txt

# Run tests with tox, ensuring all tests are executed
set +e  # Do not exit immediately on failure
tox -- -W error
exit_code=$?

# Exit with the test result code
exit $exit_code