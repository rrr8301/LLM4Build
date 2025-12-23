#!/bin/bash

set -e

# Build the project
dotnet build Radzen.Blazor/Radzen.Blazor.csproj

# Run tests
dotnet test Radzen.Blazor.Tests/Radzen.Blazor.Tests.csproj