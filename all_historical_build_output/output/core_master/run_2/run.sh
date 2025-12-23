#!/bin/bash

# Run tests and checks
set -e

# Increase the timeout for tests to prevent timeout errors
export TEST_TIMEOUT=10000

# Run tests with increased timeout
pnpm run test-unit -- --testTimeout=$TEST_TIMEOUT
pnpm run test-e2e -- --testTimeout=$TEST_TIMEOUT

# Run other checks
pnpm run lint
pnpm run format-check
pnpm run check
pnpm run test-dts