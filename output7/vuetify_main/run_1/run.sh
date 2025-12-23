#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Install project dependencies
pnpm install

# Build Vuetify
pnpm build vuetify

# Lint specific packages
pnpm lerna run lint --scope vuetify --scope @vuetify/api-generator

# Run unit tests
pnpm run test --project unit --if-present || true

# Run browser tests
pnpm run test --project browser --if-present || true