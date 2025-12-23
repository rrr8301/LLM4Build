#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Install project dependencies
pnpm install

# Run tests
set +e  # Allow the script to continue even if some tests fail
pnpm check