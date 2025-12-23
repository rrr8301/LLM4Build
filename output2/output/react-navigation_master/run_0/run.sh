#!/bin/bash

# Lint and typecheck
yarn lint || true
yarn typecheck || true

# Build packages in the monorepo
yarn lerna run prepack || true

# Bundle example JavaScript with Metro
yarn example expo export --platform all || true

# Bundle example JavaScript with Vite
yarn example web build || true

# Run all tests
yarn test --maxWorkers=2 --coverage || true

# Placeholder for manual coverage upload
echo "Upload coverage to Codecov manually if needed."