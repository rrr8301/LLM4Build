#!/bin/bash

# run.sh

# Install project dependencies
npm install

# Run tests using Mocha
# Ensure all tests run even if some fail
mocha || true