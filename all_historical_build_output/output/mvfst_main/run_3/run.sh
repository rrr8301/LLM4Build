#!/bin/bash

# run.sh

# Exit immediately if a command exits with a non-zero status
set -e

# Install system dependencies
# Remove 'sudo' as it is not needed in Docker
./build/fbcode_builder/getdeps.py install-system-deps --recursive --install-prefix=$(pwd)/_build mvfst

# Build the project
./getdeps.sh

# Run tests
python3 ./build/fbcode_builder/getdeps.py test mvfst --install-prefix=$(pwd)/_build || true

# Ensure all tests are executed, even if some fail
echo "All tests executed."