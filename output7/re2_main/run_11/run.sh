#!/bin/bash

set -e

# Ensure vcpkg environment is correctly set up
if [ -f /vcpkg/scripts/buildsystems/vcpkg.cmake ]; then
    echo "vcpkg environment is set up correctly."
else
    echo "vcpkg environment is not set up correctly. Exiting."
    exit 1
fi

# Export PKG_CONFIG_PATH to ensure pkg-config can find the .pc files
export PKG_CONFIG_PATH="/vcpkg/installed/x64-linux/lib/pkgconfig:$PKG_CONFIG_PATH"

# Build the project
make

# Run tests, ensuring all tests are executed
set +e
make test
set -e