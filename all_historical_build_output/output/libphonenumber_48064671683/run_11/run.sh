#!/bin/bash

set -e

# Build C++ project
cd cpp
mkdir -p build
cd build

# Set CMAKE_PREFIX_PATH if needed
# If Abseil is required, ensure it's installed and set the path
# export CMAKE_PREFIX_PATH=/path/to/absl

# Configure and build the project
cmake ..
make

# Run tests
set +e
if [ -f "./tools/generate_geocoding_data_test" ]; then
    ./tools/generate_geocoding_data_test
else
    echo "Test executable ./tools/generate_geocoding_data_test not found."
fi

if [ -f "./libphonenumber_test" ]; then
    ./libphonenumber_test
else
    echo "Test executable ./libphonenumber_test not found."
fi