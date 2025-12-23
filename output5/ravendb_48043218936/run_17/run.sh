#!/bin/bash

# Verify .NET installation
dotnet --info || (echo "dotnet command not found" && exit 1)

# Install project dependencies
dotnet restore

# Run tests and ensure all tests are executed
dotnet test --configuration Release --no-restore --logger "trx;LogFileName=test_results.trx"