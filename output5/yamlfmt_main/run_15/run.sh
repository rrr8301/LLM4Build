#!/bin/bash

set -e
set -o pipefail

# Run tests
# Assuming tests are defined in a script or Makefile
# Replace `make test` with the actual test command if different
if [ -f Makefile ]; then
    make test
else
    echo "No Makefile found. Please define your test commands."
    exit 1
fi

# Run yamlfmt to format YAML files
# Handle errors gracefully and output them
if ! yamlfmt .; then
    echo "YAML formatting errors detected. Please fix the following issues:"
    yamlfmt . || true
    exit 1
fi

# Additional step to output the problematic files for debugging
echo "The following files have formatting issues:"
yamlfmt . 2>&1 | grep "encountered the following formatting errors" -A 2 || true

# Exit with an error if there are any formatting issues
if yamlfmt . 2>&1 | grep -q "encountered the following formatting errors"; then
    exit 1
fi