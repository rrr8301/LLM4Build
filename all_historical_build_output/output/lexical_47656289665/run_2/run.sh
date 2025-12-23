#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Run all test suites
npm run test-unit
npm run test-e2e-chromium
npm run test-e2e-firefox
npm run test-e2e-webkit