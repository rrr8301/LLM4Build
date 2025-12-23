#!/bin/bash

# Activate environment (if any specific activation is needed, e.g., nvm)
# nvm use 20 (if nvm is used, otherwise Node.js is already set up)

# Install project dependencies
yarn install --frozen-lockfile

# Build the project
yarn build

# Run tests and ensure all tests are executed
yarn test --ci