#!/bin/bash

# run.sh

# Exit immediately if a command exits with a non-zero status
set -e

# Install project dependencies using yarn
if [ -f yarn.lock ]; then
    yarn install --frozen-lockfile
else
    npm install
fi

# Build the project
npm run build

# Run tests and ensure all tests are executed
npm test