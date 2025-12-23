#!/bin/bash

# Activate Node.js environment (if needed)
# Node.js is already installed globally

# Install project dependencies
yarn --immutable

# Build the project
yarn build:js

# Get the number of CPU cores
CPU_CORES=$(nproc)

# Run node-env tests
yarn workspace jest-environment-node test

# Run tests with retry logic
attempt_counter=0
max_attempts=3

until [ $attempt_counter -ge $max_attempts ]
do
  yarn test-ci-partial:parallel --max-workers $CPU_CORES --shard=1/4 && break
  attempt_counter=$((attempt_counter+1))
  echo "Retrying... ($attempt_counter/$max_attempts)"
done

# Run jest-jasmine tests with retry logic
attempt_counter=0

until [ $attempt_counter -ge $max_attempts ]
do
  yarn jest-jasmine-ci --max-workers $CPU_CORES --shard=1/4 && break
  attempt_counter=$((attempt_counter+1))
  echo "Retrying... ($attempt_counter/$max_attempts)"
done