#!/bin/bash

# Ensure we're in the correct directory
cd /app || { echo "Failed to change to /app directory"; exit 1; }

# Run tests with verbose output
set -ex

echo "Starting test execution at $(date)"
echo "Ruby version: $(ruby -v)"
echo "Bundler version: $(bundle -v)"

# Execute tests with detailed output
if bundle exec rake compile test; then
    echo "All tests completed successfully at $(date)"
    exit 0
else
    echo "Test execution failed at $(date)"
    exit 1
fi