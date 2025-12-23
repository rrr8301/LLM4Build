#!/bin/bash

# Activate environments if needed (e.g., source a virtualenv or conda env)
# source /path/to/venv/bin/activate  # Uncomment if using virtualenv

# Install project dependencies
# pip3 install -r requirements.txt  # Uncomment if there's a requirements file

# Build the project
mkdir -p build && cd build
cmake .. -DCMAKE_BUILD_TYPE=Release
cmake --build .

# Run tests
# Assuming tests are run using a C++ test framework or Python
# Replace with actual test command if different
ctest --output-on-failure || true  # Ensure all tests run even if some fail