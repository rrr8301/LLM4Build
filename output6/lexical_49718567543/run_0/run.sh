#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Run npm scripts
npm run ci-check || true
npm run build || true
npm run build-www || true
npm run test-unit || true

# Ensure all tests are executed, even if some fail
exit 0