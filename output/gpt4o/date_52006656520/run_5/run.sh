#!/bin/bash

# Ensure we're in the correct directory
cd /app || exit 1

# Run tests with verbose output
set -ex

echo "Starting test execution..."
if bundle exec rake compile test; then
    echo "All tests executed successfully"
    exit 0
else
    echo "Some tests failed"
    exit 1
fi