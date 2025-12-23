#!/bin/bash

# Activate nvm and use the correct Node.js version
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
nvm use

# Install project dependencies
yarn install --immutable

# Run tests and ensure all tests are executed
yarn test --maxWorkers=2 --coverage || true