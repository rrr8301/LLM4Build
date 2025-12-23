#!/bin/bash

# run.sh

# Install project dependencies
npm install --legacy-peer-deps

# Run tests using Mocha
# Ensure all tests run even if some fail
mocha || true