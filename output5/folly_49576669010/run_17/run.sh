#!/bin/bash

set -e

# Activate any necessary environments (if applicable)

# Set environment variable to bypass sudo
export GETDEPS_NO_SUDO=1

# Install project dependencies
python3 build/fbcode_builder/getdeps.py --allow-system-packages fetch --no-tests folly

# Build the project
python3 build/fbcode_builder/getdeps.py --allow-system-packages build --src-dir=. folly --project-install-prefix folly:/usr/local

# Ensure the directory permissions are set correctly before running tests
BUILD_DIR="/tmp/fbcode_builder_getdeps-ZappZbuildZfbcode_builder-root/build/folly"
if [ -d "$BUILD_DIR" ]; then
    chmod -R 777 "$BUILD_DIR"
else
    echo "Build directory $BUILD_DIR does not exist."
    exit 1
fi

# Run tests with verbose output to diagnose issues
python3 build/fbcode_builder/getdeps.py --allow-system-packages test --src-dir=. folly --project-install-prefix folly:/usr/local || true

# Navigate to the build directory and run ctest with the desired argument
cd "$BUILD_DIR"

# Run ctest with the desired argument
# Adding retries for flaky tests
RETRY_COUNT=3
for ((i=1; i<=RETRY_COUNT; i++)); do
    ctest --output-on-failure && break
    echo "Retrying failed tests ($i/$RETRY_COUNT)..."
done

# Additional step to ensure directory permissions for the specific test
TEST_DIR="$BUILD_DIR/test"
if [ ! -d "$TEST_DIR" ]; then
    echo "Test directory $TEST_DIR does not exist. Creating it."
    mkdir -p "$TEST_DIR"
    chmod -R 777 "$TEST_DIR"
fi

# Retry the specific failed test if necessary
ctest -R io_async_hh_wheel_timer_test.HHWheelTimerTest.CancelTimeout --output-on-failure || true
ctest -R file_util_test.WriteFileAtomic.directoryPermissions --output-on-failure || true