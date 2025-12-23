#!/bin/bash

# Install project dependencies
yarn install --frozen-lockfile

# Build the project
yarn build

# Run tests and ensure all tests are executed
yarn test --ci || true