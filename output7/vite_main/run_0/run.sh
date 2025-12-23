#!/bin/bash

# Install project dependencies
pnpm install

# Build the project
pnpm run build

# Run tests and ensure all tests are executed
set +e
pnpm run test-unit
pnpm run test-serve
pnpm run test-build
set -e