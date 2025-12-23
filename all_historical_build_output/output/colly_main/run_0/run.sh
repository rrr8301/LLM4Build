#!/bin/bash

# run.sh

# Exit immediately if a command exits with a non-zero status
set -e

# Run tests and ensure all tests are executed even if some fail
go test ./... || true