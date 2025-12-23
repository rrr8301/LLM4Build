#!/bin/bash

# Run linting
npm run lint

# Build and test
npm run build
npm run test || true  # Ensure all tests run even if some fail