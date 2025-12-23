#!/bin/bash

# Install project dependencies
pnpm install --frozen-lockfile

# Run tests and ensure all tests are executed
set +e  # Do not exit immediately on error
pnpm test:ci -- --test_verbose_timeout_warnings
EXIT_CODE=$?

# Exit with the test command's exit code
exit $EXIT_CODE