#!/bin/bash

set -e

# Build C++
cd cpp
mkdir -p build
cd build

# Set CMAKE_PREFIX_PATH to include absl
export CMAKE_PREFIX_PATH=/usr/local/lib/cmake/absl

cmake ..
make

# Run tests
set +e
if [ -f "./tools/generate_geocoding_data_test" ]; then
    ./tools/generate_geocoding_data_test
else
    echo "Warning: generate_geocoding_data_test not found."
fi

if [ -f "./libphonenumber_test" ]; then
    ./libphonenumber_test
else
    echo "Warning: libphonenumber_test not found."
fi