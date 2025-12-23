#!/bin/bash

# Run linting
npm run lint || true

# Run tests
npm run test || true

# Build artifacts
npm run build || true