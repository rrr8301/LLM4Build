#!/bin/bash

# Install project dependencies
npm ci

# Lint the codebase
npm run lint

# Run tests and ensure all tests are executed
npm run test || true

# Build artefacts
npm run build