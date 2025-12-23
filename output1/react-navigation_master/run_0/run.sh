#!/bin/bash

# Activate environment (if any specific activation is needed, otherwise skip)

# Install project dependencies (already done in Dockerfile, but ensure it's up-to-date)
yarn install --immutable

# Lint and typecheck
yarn lint || true
yarn typecheck || true

# Build and test
yarn lerna run prepack || true
yarn example expo export --platform all || true
yarn example web build || true
yarn test --maxWorkers=2 --coverage || true

# Note: The `|| true` ensures that all steps are executed even if some fail.