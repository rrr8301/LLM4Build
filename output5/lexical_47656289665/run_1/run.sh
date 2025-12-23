#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Run all test suites, ensuring all tests are executed even if some fail
npm run test-unit || true
npm run test-e2e-chromium || true
npm run test-e2e-firefox || true
npm run test-e2e-webkit || true