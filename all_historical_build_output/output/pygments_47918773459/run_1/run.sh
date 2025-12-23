#!/bin/bash

# Activate Python environment
python3.10 -m venv venv
source venv/bin/activate

# Install project dependencies
pip install -r requirements.txt

# Ensure tox is installed
pip install tox

# Run tests with tox, ensuring all tests are executed
set +e  # Do not exit immediately on error

# Specify the directory where tests are located if not in the root
# For example, if tests are in a 'tests' directory, use:
# tox -- -W error tests/
tox -- -W error
EXIT_CODE=$?

# Exit with the test result code
exit $EXIT_CODE