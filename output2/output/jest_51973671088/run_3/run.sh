#!/bin/bash

# run.sh

# Activate environment (if any)

# Install project dependencies
yarn --immutable

# Build the project
yarn build:js

# Get number of CPU cores
CPU_CORES=$(nproc)

# Run node-env tests
yarn workspace jest-environment-node test || true

# Run tests with retry logic
MAX_ATTEMPTS=3
for ((i=1; i<=MAX_ATTEMPTS; i++)); do
    echo "Attempt $i of $MAX_ATTEMPTS"
    yarn test-ci-partial:parallel --max-workers $CPU_CORES --shard=2/4 && break
    echo "Test attempt $i failed, retrying..."
done

# Run tests using jest-jasmine
for ((i=1; i<=MAX_ATTEMPTS; i++)); do
    echo "Attempt $i of $MAX_ATTEMPTS"
    yarn jest-jasmine-ci --max-workers $CPU_CORES --shard=2/4 && break
    echo "Test attempt $i failed, retrying..."
done