#!/bin/bash

# Activate Node.js environment
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
nvm use default

# Install project dependencies
yarn install --immutable

# Run tests
set +e  # Continue on errors
yarn test --maxWorkers=2 --coverage
set -e  # Stop on errors