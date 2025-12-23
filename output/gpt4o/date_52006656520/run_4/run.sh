#!/bin/bash

# Install project dependencies
bundle config set path 'vendor/bundle'
bundle install

# Run tests and ensure all tests are executed
set -e
echo "Starting test execution..."
if bundle exec rake compile test; then
    echo "All tests executed successfully"
    exit 0
else
    echo "Some tests failed"
    exit 1
fi