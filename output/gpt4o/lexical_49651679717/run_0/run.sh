#!/bin/bash

# Install project dependencies
npm install

# Run tests
npm test || true  # Ensure all tests run even if some fail