#!/bin/bash

set -e

# Build the project
/app/build.sh

# Run tests
cd _build
make test  # Run all tests without skipping