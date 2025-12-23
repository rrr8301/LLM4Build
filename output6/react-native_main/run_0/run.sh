#!/bin/bash

# run.sh

# Run tests and ensure all tests are executed
set +e  # Continue on errors

# Run tests
yarn test

# Capture the exit code
EXIT_CODE=$?

# Exit with the captured exit code
exit $EXIT_CODE