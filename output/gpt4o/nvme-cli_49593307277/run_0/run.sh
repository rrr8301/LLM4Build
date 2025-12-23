#!/bin/bash

# Activate environment (if any specific activation is needed, otherwise skip)

# Install project dependencies
# Assuming meson setup is required
meson setup .build

# Run build script with matrix parameters
scripts/build.sh -b release -c gcc -x

# Run tests
# Assuming meson is used for testing as well
meson test -C .build --no-rebuild --print-errorlogs || true

# Ensure all test cases are executed, even if some fail