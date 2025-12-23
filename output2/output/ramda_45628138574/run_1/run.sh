#!/bin/bash

# Install project dependencies
npm ci

# Run linting
npm run lint

# Run tests
npm run test

# Build artifacts
npm run build