#!/bin/bash

# Exit immediately if any command fails
set -e

# Change to build directory and run C++ tests
echo "Running C++ tests..."
cd build && ctest --output-on-failure

# Run Python tests (continue even if some fail)
echo "Running Python tests..."
cd .. && pytest --junitxml=test-results/pytest/results.xml tests/test_*.py || true

# Print test summary
echo "Test execution completed."