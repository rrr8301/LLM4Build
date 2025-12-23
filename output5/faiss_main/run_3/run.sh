#!/bin/bash

# Activate the virtual environment
source venv/bin/activate

# Build the project
mkdir -p build && cd build
cmake ..
make

# Run tests
# Assuming tests are run using a Python test framework like pytest
# Ensure all tests are executed even if some fail
pytest --maxfail=0 --continue-on-collection-errors

# Deactivate the virtual environment
deactivate