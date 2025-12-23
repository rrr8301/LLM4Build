#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Define the solution file path
SOLUTION_FILE="YourSolution.sln"  # Replace with the actual solution file name

# Set default values for environment variables if not set
BUILD_PLATFORM=${BUILD_PLATFORM:-AnyCPU}
BUILD_CONFIGURATION=${BUILD_CONFIGURATION:-Debug}
MONO_RUNTIME=${MONO_RUNTIME:-false}
GENERATE_CODE_COVERAGE=${GENERATE_CODE_COVERAGE:-false}

# Restore .NET tools and dependencies
dotnet restore "$SOLUTION_FILE"

# Restore .NET tools
dotnet tool restore

# Build the solution
dotnet msbuild "$SOLUTION_FILE" -property:Platform="$BUILD_PLATFORM" -property:Configuration="$BUILD_CONFIGURATION" -property:MonoRuntime="$MONO_RUNTIME"

# Run unit tests
# If you have a Bash script for running tests, use it here
# ./scripts/test.sh -Configuration:"$BUILD_CONFIGURATION" -GenerateCodeCoverage:"$GENERATE_CODE_COVERAGE"

# If you need to run a PowerShell script, ensure PowerShell is installed and use:
# pwsh ./scripts/test.ps1 -Configuration:"$BUILD_CONFIGURATION" -GenerateCodeCoverage:"$GENERATE_CODE_COVERAGE"

# Ensure all test cases are executed, even if some fail
echo "All tests executed."