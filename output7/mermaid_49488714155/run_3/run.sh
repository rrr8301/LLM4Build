#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Install project dependencies with strict-peer-dependencies set to false
pnpm install --config.strict-peer-dependencies=false

# Run tests and ensure all tests are executed even if some fail
pnpm test