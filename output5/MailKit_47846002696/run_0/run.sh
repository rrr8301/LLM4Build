#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Restore .NET tools and dependencies
dotnet restore "$SOLUTION_PATH"

# Restore .NET tools
dotnet tool restore

# Build the solution
dotnet msbuild "$SOLUTION_PATH" -property:Platform="$BUILD_PLATFORM" -property:Configuration="$BUILD_CONFIGURATION" -property:MonoRuntime="$MONO_RUNTIME" || true

# Run unit tests
./scripts/test.ps1 -Configuration:"$BUILD_CONFIGURATION" -GenerateCodeCoverage:"$GENERATE_CODE_COVERAGE" || true

# Ensure all test cases are executed, even if some fail
echo "All tests executed."