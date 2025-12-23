#!/bin/bash

# Activate environment variables
export DOTNET_SKIP_FIRST_TIME_EXPERIENCE=1
export DOTNET_NOLOGO=true

# Check style format
dotnet format --verify-no-changes --verbosity diagnostic

# Build Garnet
dotnet build --configuration Release

# Run tests
dotnet test test/Garnet.test -f net8.0 --logger "console;verbosity=detailed" --logger trx --results-directory "GarnetTestResults-ubuntu-22.04-net8.0-Release-Garnet.test" || true

# Note: Test results can be manually copied from the container
echo "Test results are available in the GarnetTestResults-ubuntu-22.04-net8.0-Release-Garnet.test directory."