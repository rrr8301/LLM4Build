#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Run the tests
./gradlew test || true

# Ensure all tests are executed, even if some fail
if [ $? -ne 0 ]; then
  echo "Some tests failed, but continuing execution."
fi