#!/bin/bash

# run.sh

# Exit immediately if a command exits with a non-zero status
set -e

# Install project dependencies using yarn
# Temporarily disable frozen-lockfile to regenerate yarn.lock if needed
if [ -f yarn.lock ]; then
    yarn install || (rm yarn.lock && yarn install)
else
    npm install
fi

# Build the project
npm run build

# Run tests and ensure all tests are executed
npm test