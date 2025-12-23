#!/bin/bash

# Navigate to the C++ directory
cd cpp

# Create and navigate to the build directory
mkdir -p build
cd build

# Build the project
cmake ..
make

# Run tests
set +e  # Continue executing even if some tests fail
./tools/generate_geocoding_data_test
./libphonenumber_test