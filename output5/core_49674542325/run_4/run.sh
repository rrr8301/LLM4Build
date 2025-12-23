#!/bin/bash

set -e

# Activate environment variables if needed
export PUPPETEER_SKIP_DOWNLOAD=true

# Install project dependencies
pnpm install

# Run tests
set +e
pnpm run test-unit
pnpm run test-unit compiler
pnpm run test-unit server-renderer
pnpm run test-e2e
pnpm run test-e2e-vapor
pnpm run lint
pnpm run format-check
pnpm run check
pnpm run test-dts
set -e