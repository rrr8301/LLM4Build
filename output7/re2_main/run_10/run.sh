#!/bin/bash

set -e

# Ensure vcpkg environment is correctly set up
if [ -f /vcpkg/scripts/buildsystems/vcpkg.cmake ]; then
    echo "vcpkg environment is set up correctly."
else
    echo "vcpkg environment is not set up correctly. Exiting."
    exit 1
fi

# Build the project
make

# Run tests, ensuring all tests are executed
set +e
make test
set -e