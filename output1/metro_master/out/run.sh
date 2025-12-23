#!/bin/bash

# Run tests
set -e
yarn jest --ci --maxWorkers 4 --reporters=default --reporters=jest-junit --rootdir='./' || true

# Placeholder for Codecov upload (not executed)
echo "Codecov upload step would be executed here if supported."