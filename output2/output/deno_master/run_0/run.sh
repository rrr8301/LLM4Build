#!/bin/bash

# Run tests and ensure all tests are executed
set +e  # Continue on errors

# Run tests
npm test

# Capture the exit code
exit_code=$?

# Exit with the captured exit code
exit $exit_code