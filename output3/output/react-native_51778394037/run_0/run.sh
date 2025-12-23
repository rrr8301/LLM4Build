#!/bin/bash

# Activate environment variables if needed (none specified)

# Install project dependencies
yarn install --non-interactive --frozen-lockfile

# Run Fantom tests
set +e  # Continue execution even if some tests fail
yarn fantom
set -e  # Re-enable exit on error