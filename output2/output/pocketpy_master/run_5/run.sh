#!/bin/bash

# Activate environments if any (none specified)

# Install project dependencies if any (none specified)

# Compile and Test
python3 scripts/check_pragma_once.py include
mkdir -p output/x86_64

# Ensure cmake_build.py uses python3
python3 cmake_build.py Release -DPK_BUILD_MODULE_LZ4=ON -DPK_BUILD_MODULE_CUTE_PNG=ON

# Run tests and ensure all tests are executed
set +e  # Do not exit immediately on error
python3 scripts/run_tests.py
set -e  # Re-enable exit on error

# Copy necessary files to output
if [ -f main ]; then
    cp main output/x86_64
else
    echo "Error: 'main' executable not found."
    exit 1
fi

if [ -f libpocketpy.so ]; then
    cp libpocketpy.so output/x86_64
else
    echo "Error: 'libpocketpy.so' not found."
    exit 1
fi