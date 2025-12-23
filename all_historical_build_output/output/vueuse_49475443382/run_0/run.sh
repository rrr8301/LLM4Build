#!/bin/bash

# Install project dependencies
nci

# Build the project
nr build

# Typecheck the project
nr typecheck

# Run unit tests
pnpm run test:unit || true

# Run browser tests
pnpm run test:browser || true

# Run attw tests if Node.js version is 20.x
if [[ "$(node -v)" == v20.* ]]; then
  pnpm test:attw || true
fi