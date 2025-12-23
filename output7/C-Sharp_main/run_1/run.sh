#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Build the project
dotnet build

# Run tests and ensure all tests are executed even if some fail
dotnet test --no-build --logger "trx;LogFileName=test_results.trx" || true