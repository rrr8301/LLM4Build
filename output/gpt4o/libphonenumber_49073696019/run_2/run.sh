#!/bin/bash

# Navigate to the C++ directory
cd cpp

# Create and navigate to the build directory
mkdir -p build
cd build

# Build the project with retry in case of network issues
set +e
for i in {1..3}; do
    cmake .. && break
    if [ $i -eq 3 ]; then
        echo "CMake failed after 3 attempts"
        exit 1
    fi
    echo "CMake failed, retrying..."
    sleep 5
done

# Build the project
make

# Run tests
set +e  # Continue executing even if some tests fail
if [ -f "./tools/generate_geocoding_data_test" ]; then
    ./tools/generate_geocoding_data_test
else
    echo "generate_geocoding_data_test not found"
fi

if [ -f "./libphonenumber_test" ]; then
    ./libphonenumber_test
else
    echo "libphonenumber_test not found"
fi