#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Build the project
make configure
./configure --prefix=/usr
make all

# Run tests
# Ensure all tests are executed, even if some fail
make test