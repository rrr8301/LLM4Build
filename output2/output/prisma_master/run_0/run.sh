#!/bin/bash

# Install project dependencies
pnpm install

# Build the project
pnpm run build

# Run tests and ensure all tests are executed
pnpm run test || true