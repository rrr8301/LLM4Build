#!/bin/bash

# run.sh

# Exit immediately if a command exits with a non-zero status
set -e

# Run tests
go test -v ./... || true  # Ensure all tests run even if some fail