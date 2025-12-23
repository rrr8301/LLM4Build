#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Ensure all dependencies are installed
pnpm install

# Build the project
pnpm run build

# Run tests, ensuring all tests are executed even if some fail
set +e
pnpm test
TEST_EXIT_CODE=$?
set -e

# Exit with the test command's exit code
exit $TEST_EXIT_CODE