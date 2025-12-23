#!/bin/bash

set -e

# Compile the project
mkdir -p build
cd build
cmake ..
make

# Run tests
# Assuming tests are executable binaries in the build directory
for test in $(ls test_*); do
    ./$test || true
done