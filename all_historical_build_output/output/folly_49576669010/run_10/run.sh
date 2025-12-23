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
chmod -R 777 /tmp/fbcode_builder_getdeps-ZappZbuildZfbcode_builder-root/build/folly

# Run tests with verbose output to diagnose issues
python3 build/fbcode_builder/getdeps.py --allow-system-packages test --src-dir=. folly --project-install-prefix folly:/usr/local

# Navigate to the build directory and run ctest with the desired argument
cd /tmp/fbcode_builder_getdeps-ZappZbuildZfbcode_builder-root/build/folly

# Run ctest with the desired argument
ctest --output-on-failure