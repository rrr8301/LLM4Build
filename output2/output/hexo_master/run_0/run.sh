#!/bin/bash

# Install project dependencies
npm install

# Run tests and ensure all tests are executed
npm test -- --no-parallel || true

# Run coverage
npm run test-cov || true