#!/bin/bash

# Activate the Python environment
source /usr/bin/activate

# Install project dependencies
pip install -r requirements.txt

# Run tests using tox
# Ensure all test cases are executed, even if some fail
set +e
tox -- -W error
set -e