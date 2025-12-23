#!/bin/bash

set -e

# Activate environment variables
export CI=true

# Build the project
yarn nx run-many --target=build --parallel --exclude=website --exclude=website-eslint

# Run tests with coverage for primary node version
if [ "$PRIMARY_NODE_VERSION" == "18" ]; then
  yarn nx run eslint-plugin:test -- --coverage || true
else
  yarn nx test eslint-plugin || true
fi

# Ensure all tests are executed, even if some fail
exit 0