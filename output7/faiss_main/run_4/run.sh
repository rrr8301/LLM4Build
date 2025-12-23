#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Activate the Python environment (if any virtual environment is used)
# source /path/to/venv/bin/activate

# Install project dependencies
# Check if the requirements.txt file exists before attempting to install
if [ -f /app/requirements.txt ]; then
    pip3 install --no-cache-dir -r /app/requirements.txt
fi

# Build the project
mkdir -p build && cd build
cmake ..
make

# Run tests
# Ensure all tests are executed, even if some fail
set +e
ctest --output-on-failure
set -e