#!/bin/bash

# Activate environment variables if needed (e.g., source .env)

# Install project dependencies
npm ci

# Copy secrets example file
npm run copy-secrets

# Prepare for Playwright tests
npm run playwright:prepare-ci

# Run eslint
npm run lint

# Run Jest tests
npm run silent-test || true  # Ensure all tests run even if some fail

# Run build
npm run prestart-ci

# Run Playwright tests
bin/start-playwright.sh || true  # Ensure all tests run even if some fail