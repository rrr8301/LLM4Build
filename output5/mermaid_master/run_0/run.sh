#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Run build
pnpm --filter mermaid run docs:build:vitepress

# Run tests and ensure all tests are executed
set +e
pnpm test:coverage
pnpm exec vitest run ./packages/mermaid/src/diagrams/gantt/ganttDb.spec.ts --coverage
pnpm test:check:tsc
set -e

# Placeholder for manual Codecov upload
echo "Please upload coverage to Codecov manually."