#!/bin/bash

# Navigate to the C++ directory
cd cpp

# Create and navigate to the build directory
mkdir -p build
cd build

# Set Abseil path
export CMAKE_PREFIX_PATH=/usr/local/lib/cmake/absl

# Build the project with retry in case of network issues
set +e
for i in {1..3}; do
    cmake -DCMAKE_POSITION_INDEPENDENT_CODE=ON -DCMAKE_PREFIX_PATH=/usr/local/lib/cmake/absl .. && break
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

# Run additional tests if they exist
if [ -f "./geocoding_test" ]; then
    ./geocoding_test
fi

if [ -f "./test/phonenumberutil_test" ]; then
    ./test/phonenumberutil_test
fi