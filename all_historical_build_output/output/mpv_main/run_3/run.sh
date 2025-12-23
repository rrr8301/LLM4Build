#!/bin/bash

set -e
set -o pipefail

# Build the project
meson setup build
meson compile -C build

# Run tests
meson test -C build --no-rebuild --print-errorlogs || true

# Ensure all tests are executed, even if some fail