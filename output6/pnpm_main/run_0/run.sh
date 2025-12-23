#!/bin/bash

# Activate pnpm environment
source ~/.bashrc

# Install project dependencies
pnpm install

# Run tests
set +e  # Continue execution even if some tests fail
pnpm run test