#!/bin/bash

# Activate Python environment (if any)
# Assuming no virtual environment is specified, using system Python

# Install project dependencies
python3.12 -m pip install --no-cache-dir -r requirements.txt

# Run build and test script
# Ensure all tests are executed, even if some fail
set +e
bash ci/run-build-and-tests.sh
set -e