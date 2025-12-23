#!/bin/bash

# Check if the dist directory contains any .tar.gz files
if [ -z "$(find dist -name '*.tar.gz')" ]; then
  echo "Error: No package files found in the dist directory."
  exit 1
fi

# Run tests with coverage
tox run -e py311-coverage --installpkg "$(find dist/*.tar.gz)"

# Generate coverage report
python3.11 -m coverage xml