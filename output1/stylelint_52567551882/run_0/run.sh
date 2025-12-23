#!/bin/bash

# Install project dependencies
npm ci

# Run tests with coverage
npm run test-coverage || true

# Note: Codecov upload is not supported in this script.
# Please upload coverage manually if needed.