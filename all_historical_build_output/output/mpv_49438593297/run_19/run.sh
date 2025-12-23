#!/bin/bash

set -e

# Ensure the environment variables are set correctly
export PKG_CONFIG_PATH="/usr/local/lib/pkgconfig:$PKG_CONFIG_PATH"
export LD_LIBRARY_PATH="/usr/local/lib:$LD_LIBRARY_PATH"

# Build with Meson
./ci/build-tumbleweed.sh -Db_ndebug=true

# Run Meson tests
export LSAN_OPTIONS="suppressions=$(pwd)/.lsan_suppressions"
meson test -C build

# Print logs if there are failures
if [ $? -ne 0 ]; then
  echo "Meson build or tests failed. Printing logs..."
  cat ./build/meson-logs/meson-log.txt || true
  cat ./build/meson-logs/testlog.txt || true
fi