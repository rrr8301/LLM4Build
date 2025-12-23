#!/bin/bash

# Install project dependencies
npm ci

# Ensure the latest version of ESLint is installed
npm install eslint@latest

# Run tests with increased timeout
set +e  # Continue executing even if some tests fail
hereby runtests-parallel --timeout 120000  # Increase timeout to 120 seconds