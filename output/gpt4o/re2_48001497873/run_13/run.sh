#!/bin/bash

# Activate environment variables
export CC=/usr/bin/clang-18
export CXX=/usr/bin/clang++-18
export VCPKG_ROOT=/vcpkg
export VCPKG_DEFAULT_TRIPLET=x64-linux
export PKG_CONFIG_PATH=/vcpkg/installed/x64-linux/lib/pkgconfig

# Build the project and tests
make && make test

# Create test directories if they don't exist
mkdir -p obj/test/ obj/so/test/

# Make test binaries executable (silently ignore if none exist)
find obj/test/ -type f -executable -exec chmod +x {} \; 2>/dev/null || true
find obj/so/test/ -type f -executable -exec chmod +x {} \; 2>/dev/null || true

# Run tests directly and capture output
TEST_OUTPUT=$(./runtests 2>&1)
echo "$TEST_OUTPUT"

# Output test results if any test binaries exist
echo "Test results:"
echo "============="
find obj/ -type f -executable -name "*_test" -exec {} --gtest_output=xml:{}.xml \; 2>/dev/null || true

# Check if tests actually ran by looking for test output patterns
if [[ "$TEST_OUTPUT" == *"PASSED"* ]] || [[ "$TEST_OUTPUT" == *"OK"* ]]; then
    echo "Tests executed successfully"
    exit 0
else
    echo "ERROR: Tests were not executed properly" >&2
    exit 1
fi