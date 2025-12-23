#!/bin/bash

# Activate environments if any (none in this case)

# Install project dependencies
# Assuming CMakeLists.txt is present in the root directory
mkdir -p build && cd build
cmake ..
make

# Run tests
# Assuming tests are run using a make target or a specific command
# Ensure all tests are executed even if some fail
set +e
make test
set -e