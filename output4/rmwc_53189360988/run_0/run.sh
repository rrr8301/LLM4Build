#!/bin/bash

# Activate environment variables if needed (none specified)

# Install project dependencies
npm install

# Run tests with coverage
npm test --coverage=true || true  # Ensure all tests run even if some fail