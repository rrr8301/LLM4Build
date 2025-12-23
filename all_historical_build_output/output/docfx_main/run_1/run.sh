#!/bin/bash

# Activate .NET environment
export PATH="$PATH:/root/.dotnet/tools"

# Build the project
dotnet build

# Run tests, ensuring all tests are executed
dotnet test --no-build --logger "trx;LogFileName=test_results.trx"

# Note: The '|| true' was removed to ensure that the script fails if tests fail