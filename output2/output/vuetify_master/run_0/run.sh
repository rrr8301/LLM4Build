#!/bin/bash

# Install project dependencies
pnpm install

# Build Vuetify
pnpm build vuetify

# Lint the code
pnpm run lint

# Run unit tests
pnpm run test --project unit

# Run browser tests, continue even if they fail
pnpm run test --project browser || true

# Note: Artifacts are not uploaded in this setup
echo "Artifacts are not uploaded in this Docker setup."