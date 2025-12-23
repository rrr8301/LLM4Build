#!/bin/bash

# Run build
yarn nx run-many --target=build --parallel --exclude=website --exclude=website-eslint

# Run tests
set +e  # Continue execution even if some tests fail
yarn test
yarn test-integration
set -e  # Re-enable exit on error