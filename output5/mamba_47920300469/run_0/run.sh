#!/bin/bash

# Activate any necessary environments (if applicable)
# For example, source a virtualenv or conda environment

# Install project dependencies
# Assuming a CMake-based C++ project
mkdir -p build && cd build
cmake .. -DCMAKE_BUILD_TYPE=Release
cmake --build .

# Run tests
# Assuming tests are run via CTest or a similar framework
ctest --output-on-failure || true

# Ensure all tests are executed, even if some fail
# The `|| true` ensures the script continues even if tests fail