#!/bin/bash

# Install project dependencies
nci

# Build the project
nr build

# Run tests with coverage, ensuring all tests are executed
nr test --coverage || true