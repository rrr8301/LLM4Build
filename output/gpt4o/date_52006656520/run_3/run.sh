#!/bin/bash

# Install project dependencies
bundle config set path 'vendor/bundle'
bundle install

# Run tests and ensure all tests are executed
set -e
bundle exec rake compile test

# Explicitly exit with success if we reach this point
exit 0