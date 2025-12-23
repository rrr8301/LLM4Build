#!/bin/bash

# Activate Python environment (if any virtual environment is used, activate it here)

# Install project dependencies
pip3 install -r preview/requirements.txt

# Run tests
set +e  # Continue execution even if some tests fail
cd test
./test.sh