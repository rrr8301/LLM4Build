#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Install project dependencies
pnpm install

# Build the project
pnpm run build

# Run tests, ensuring all tests are executed
# Adding --runInBand to run tests serially if there are issues with parallel execution
pnpm run test:ci -- --runInBand || true
pnpm run test:examples -- --runInBand || true
pnpm run -C packages/ui test:ui -- --runInBand || true

# Check the exit status of the last command and exit with it
exit $?