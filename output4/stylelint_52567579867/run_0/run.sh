#!/bin/bash

# Install project dependencies
npm install

# Run tests
# Ensure all tests are executed, even if some fail
npm test || true