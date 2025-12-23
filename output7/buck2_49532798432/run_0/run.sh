#!/bin/bash

# Activate environments if needed (e.g., source venv/bin/activate)

# Install project dependencies
# pip3 install -r requirements.txt  # Uncomment if there's a requirements file

# Run tests
# Assuming run_test_py is a script or command to run Python tests
set +e  # Continue on errors
./.github/actions/run_test_py
set -e