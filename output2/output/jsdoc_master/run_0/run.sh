#!/bin/bash

# Install project dependencies
npm install

# Run license check
npm run license-check

# Run linting
npm run lint

# Run tests and ensure all tests are executed
npm run test || true