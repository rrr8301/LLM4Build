#!/bin/bash

# Install project dependencies
yarn --immutable

# Build the project
yarn build

# Run tests and ensure all tests are executed
yarn test || true

# Run coverage
yarn jest-coverage --color --config jest.config.ci.mjs || true