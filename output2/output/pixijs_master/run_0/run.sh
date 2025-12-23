#!/bin/bash

# Run build
npm run dist

# Run tests
set +e  # Continue execution even if some tests fail
npm run test:scene -- --maxWorkers=50%
xvfb-run --auto-servernum npm run test:unit -- --maxWorkers=50%
set -e  # Re-enable exit on error