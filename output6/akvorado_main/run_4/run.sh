#!/bin/bash

# run.sh

# Exit immediately if a command exits with a non-zero status
set -e

# Build the project
npm run build

# Run tests and ensure all tests are executed
npm test