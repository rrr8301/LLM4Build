#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Activate the Python environment (if any virtual environment is used)
# source /path/to/venv/bin/activate

# Install project dependencies
pip3 install --no-cache-dir -r requirements.txt

# Build the project
mkdir -p build && cd build
cmake ..
make

# Run tests
# Ensure all tests are executed, even if some fail
set +e
ctest --output-on-failure
set -e