#!/bin/bash

# Install project dependencies
nci

# Build the project
nr build

# Typecheck
nr typecheck

# Run all tests, ensuring all tests are executed even if some fail
set +e
pnpm run test:cov
pnpm run test:browser
pnpm run test:server
pnpm test:attw
set -e