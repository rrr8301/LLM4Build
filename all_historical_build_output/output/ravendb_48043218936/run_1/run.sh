#!/bin/bash

# Activate environment (if any specific activation is needed, otherwise skip)
# Example: source /path/to/activate

# Verify .NET installation
dotnet --info

# Install project dependencies
dotnet restore

# Run tests and ensure all tests are executed
dotnet test --configuration Release --no-restore --logger "trx;LogFileName=test_results.trx" || true