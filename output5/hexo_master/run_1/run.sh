#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Run tests
npm test -- --no-parallel

# Run coverage
npm run test-cov