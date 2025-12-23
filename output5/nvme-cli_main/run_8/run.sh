#!/bin/bash

# run.sh

# Exit immediately if a command exits with a non-zero status
set -e

# Build the project
meson setup .build
meson compile -C .build

# Run tests
# Assuming tests are part of the build process or a separate command
# Replace `meson test` with the actual test command if different
meson test -C .build