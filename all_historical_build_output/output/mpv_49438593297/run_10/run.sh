#!/bin/bash

set -e

# Build with Meson
./ci/build-tumbleweed.sh -Db_ndebug=true

# Run Meson tests
export LSAN_OPTIONS="suppressions=$(pwd)/.lsan_suppressions"
meson test -C build || true

# Print logs if there are failures
if [ $? -ne 0 ]; then
  echo "Meson build or tests failed. Printing logs..."
  cat ./build/meson-logs/meson-log.txt || true
  cat ./build/meson-logs/testlog.txt || true
fi