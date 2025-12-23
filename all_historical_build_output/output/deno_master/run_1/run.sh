#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Run build
npm run build

# Run tests and ensure all tests are executed
npm test