#!/bin/bash

# Activate environment variables if needed (none specified)

# Install project dependencies
pnpm install --frozen-lockfile

# Run unit tests and ensure all tests are executed
pnpm test:coverage || true

# Run ganttDb tests using California timezone
TZ=America/Los_Angeles pnpm exec vitest run ./packages/mermaid/src/diagrams/gantt/ganttDb.spec.ts --coverage || true

# Verify out-of-tree build with TypeScript
pnpm test:check:tsc || true