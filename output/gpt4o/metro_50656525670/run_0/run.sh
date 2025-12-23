#!/bin/bash

# Activate environment (if any specific activation is needed, otherwise skip)
# Example: source /path/to/venv/bin/activate

# Install project dependencies
yarn install --frozen-lockfile --non-interactive --ignore-scripts

# Run tests
yarn jest --ci --maxWorkers 4 --reporters=default --reporters=jest-junit --rootdir='./' || true

# Ensure all tests are executed, even if some fail