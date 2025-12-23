#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Install project dependencies
pnpm install

# Run tests
set +e  # Allow the script to continue even if some tests fail
pnpm check

# Run end-to-end tests
pnpm exec playwright install-deps
pnpm test:e2e-dev && pnpm test:e2e-build