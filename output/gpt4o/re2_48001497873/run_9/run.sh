#!/bin/bash

# Activate environment variables
export CC=/usr/bin/clang-18
export CXX=/usr/bin/clang++-18
export VCPKG_ROOT=/vcpkg
export VCPKG_DEFAULT_TRIPLET=x64-linux
export PKG_CONFIG_PATH=/vcpkg/installed/x64-linux/lib/pkgconfig

# Build the project
make

# Make test binaries executable
find obj/test/ -type f -executable -exec chmod +x {} \;
find obj/so/test/ -type f -executable -exec chmod +x {} \;

# Run tests using make test which properly discovers tests
make test || true

# Additionally run ctest with verbose output for debugging
ctest --verbose --output-on-failure || true

# Run tests directly if make test fails
./runtests || true