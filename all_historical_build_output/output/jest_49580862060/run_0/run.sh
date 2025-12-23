#!/bin/bash

# Activate environment (if any)

# Run node-env tests
yarn workspace jest-environment-node test

# Function to retry a command
retry() {
  local n=1
  local max=3
  local delay=5
  while true; do
    "$@" && break || {
      if [[ $n -lt $max ]]; then
        ((n++))
        echo "Command failed. Attempt $n/$max:"
        sleep $delay;
      else
        echo "The command has failed after $n attempts."
        return 1
      fi
    }
  done
}

# Run tests with retry logic
retry yarn test-ci-partial:parallel --max-workers $(nproc) --shard=1/4
retry yarn test-ci-partial:parallel --max-workers $(nproc) --shard=2/4
retry yarn test-ci-partial:parallel --max-workers $(nproc) --shard=3/4
retry yarn test-ci-partial:parallel --max-workers $(nproc) --shard=4/4

# Run tests using jest-jasmine
retry yarn jest-jasmine-ci --max-workers $(nproc) --shard=1/4
retry yarn jest-jasmine-ci --max-workers $(nproc) --shard=2/4
retry yarn jest-jasmine-ci --max-workers $(nproc) --shard=3/4
retry yarn jest-jasmine-ci --max-workers $(nproc) --shard=4/4