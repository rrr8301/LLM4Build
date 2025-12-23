#!/bin/bash

# Install project dependencies
bundle install

# Run tests and ensure all tests are executed
set +e
bundle exec rake compile test
set -e