#!/bin/bash

# run.sh

# Restore dependencies
dotnet restore Microsoft.FluentUI-v5.sln

# Build the project
dotnet build "$PROJECTS" --configuration Release -warnaserror

# Run tests and ensure all tests are executed
dotnet test "$TESTS" --logger:trx --results-directory ./TestResults --verbosity normal --configuration Release /p:CollectCoverage=true /p:CoverletOutputFormat=cobertura /p:DebugType=Full || true

# Note: The '|| true' ensures that the script continues even if tests fail