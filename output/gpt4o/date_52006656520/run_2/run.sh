#!/bin/bash

# Install project dependencies
bundle config set path 'vendor/bundle'
bundle install

# Run tests and ensure all tests are executed
set +e
bundle exec rake compile test
TEST_RESULT=$?
set -e

# Exit with test result status
exit $TEST_RESULT