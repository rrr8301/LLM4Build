#!/bin/bash

# Check if Makefile exists, if not, exit with an error
if [ ! -f Makefile ]; then
  echo "Error: No Makefile found. Please ensure a Makefile is present or generated."
  exit 1
fi

# Build the project
make

# Run tests, ensuring all tests are executed even if some fail
make test