#!/bin/bash

set -e

# Build C++ project
cd cpp
mkdir -p build
cd build
cmake ..
make

# Run tests
set +e
./tools/generate_geocoding_data_test
./libphonenumber_test