#!/bin/bash

# Run tests in parallel
yarn test-ci-partial:parallel --max-workers $(nproc) || true

# Run tests with coverage
yarn jest-coverage --color --config jest.config.ci.mjs --max-workers $(nproc) || true

# Map coverage
node ./scripts/mapCoverage.mjs || true