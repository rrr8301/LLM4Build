#!/bin/bash

# run.sh

# Exit immediately if a command exits with a non-zero status
set -e

# Run tests and ensure all tests are executed
dotnet test Radzen.Blazor.Tests/Radzen.Blazor.Tests.csproj --logger "trx;LogFileName=test_results.trx"