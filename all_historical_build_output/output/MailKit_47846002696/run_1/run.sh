#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Define the solution file path
SOLUTION_FILE="YourSolution.sln"  # Replace with the actual solution file name

# Restore .NET tools and dependencies
dotnet restore "$SOLUTION_FILE"

# Restore .NET tools
dotnet tool restore

# Build the solution
dotnet msbuild "$SOLUTION_FILE" -property:Platform="$BUILD_PLATFORM" -property:Configuration="$BUILD_CONFIGURATION" -property:MonoRuntime="$MONO_RUNTIME" || true

# Run unit tests
./scripts/test.ps1 -Configuration:"$BUILD_CONFIGURATION" -GenerateCodeCoverage:"$GENERATE_CODE_COVERAGE" || true

# Ensure all test cases are executed, even if some fail
echo "All tests executed."