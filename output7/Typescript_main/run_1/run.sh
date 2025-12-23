#!/bin/bash

# Install project dependencies
npm ci

# Ensure the latest version of ESLint is installed
npm install eslint@latest

# Run tests
set +e  # Continue executing even if some tests fail
hereby runtests-parallel