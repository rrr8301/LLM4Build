#!/bin/bash

# run.sh

# Exit immediately if a command exits with a non-zero status
set -e

# Ensure submodules are initialized and updated
# This step is assumed to be done before building the Docker image
# git submodule update --init --recursive

# Generate UT build cache
cd FppTestProject
fprime-util generate --ut

# Build UTs
cd FppTest
fprime-util build --ut

# Run UTs
set +e  # Allow script to continue even if some tests fail
fprime-util check
set -e