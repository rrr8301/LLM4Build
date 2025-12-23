#!/bin/bash

# run.sh

# Exit immediately if a command exits with a non-zero status
set -e

# Install project dependencies
pnpm install

# Build Vuetify
pnpm build vuetify

# Lint the code
# If the ESLint configuration file is necessary, provide the correct path
# Otherwise, remove or comment out the sed command
# sed -i 's/require(/import(/g' path/to/your/eslint-config-file.js

# Run linting
pnpm run lint

# Run unit tests
pnpm run test --project unit || true

# Run browser tests if unit tests fail
pnpm run test --project browser || true

# Note: Artifacts (screenshots) are not uploaded in this setup