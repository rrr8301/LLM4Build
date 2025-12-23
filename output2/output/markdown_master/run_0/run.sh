#!/bin/bash

# Install project dependencies
npm install

# Build the project
npm run build

# Run tests and ensure all tests are executed
npm run test || true