#!/bin/bash

# Step 1: Activate the virtual environment (if applicable)
# Note: Assuming no virtual environment is explicitly created in the instructions

# Step 2: Install project dependencies
pip3 install -e .
pip3 install tox
pip3 install pyink==24.3.0

# Step 3: Run tests
# Ensure all tests are executed, even if some fail
set +e  # Do not exit immediately on error
tox
pyink .

# Step 4: Exit with the status of the last command
exit $?