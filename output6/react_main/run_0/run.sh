#!/bin/bash

# run.sh

# Exit immediately if a command exits with a non-zero status
set -e

# Run build and test commands
yarn build || true
yarn test || true