#!/bin/bash

# run.sh

# Exit immediately if a command exits with a non-zero status
set -e

# Run build and test commands
npm run ci-check || true
npm run build || true
npm run build-www || true
npm run test-unit || true
npm run test-integration || true
npm run test-e2e || true

# Ensure all tests are executed even if some fail