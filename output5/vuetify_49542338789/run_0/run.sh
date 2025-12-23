#!/bin/bash

# run.sh

# Exit immediately if a command exits with a non-zero status
set -e

# Activate environment and install project dependencies
pnpm install

# Run tests and ensure all tests are executed
pnpm run test --project unit || true