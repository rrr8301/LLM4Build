#!/bin/bash

# Step 1: Install project dependencies
pip3 install .
pip3 install tox
pip3 install pyink==24.3.0

# Step 2: Run tests
# Ensure all tests are executed, even if some fail
set +e  # Do not exit immediately on error
tox
pyink .

# Step 3: Exit with the status of the last command
exit $?