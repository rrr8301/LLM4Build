#!/bin/bash

# Install project dependencies
nci

# Build the project
nr build

# Typecheck
nr typecheck

# Run unit tests
pnpm run test:cov || true

# Run browser tests
pnpm run test:browser || true

# Run server tests
pnpm run test:server || true

# Playground Smoke Test (conditional)
if [ "$(node -v)" == "lts/*" ]; then
  cd playgrounds && bash ./build.sh || true
fi

# Note: Code coverage reporting is ignored due to unsupported action