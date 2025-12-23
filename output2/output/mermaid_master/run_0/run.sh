#!/bin/bash

# Install project dependencies
pnpm install --frozen-lockfile

# Verify release version
pnpm --filter mermaid run docs:verify-version || true

# Run build
pnpm --filter mermaid run docs:build:vitepress || true

# Run unit tests
pnpm test:coverage || true

# Run ganttDb tests using California timezone
TZ=America/Los_Angeles pnpm exec vitest run ./packages/mermaid/src/diagrams/gantt/ganttDb.spec.ts --coverage || true

# Verify out-of-tree build with TypeScript
pnpm test:check:tsc || true

# Fix linting
pnpm -w run lint:fix || true

# Sync configuration files
pnpm run --filter mermaid types:build-config || true

# Build documentation
cd ./packages/mermaid && pnpm run docs:build || true