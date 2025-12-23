#!/bin/bash

# Activate environment variables if needed (none specified)

# Install project dependencies
npm ci

# Run tests and ensure all tests are executed
npm test || true