#!/bin/bash

# Ensure the test-results directory exists
mkdir -p test-results

# Run tests
pytest --junitxml=test-results/results.xml

# Exit with the result of pytest
exit $?