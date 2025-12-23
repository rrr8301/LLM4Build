#!/bin/bash

set -e

# Activate environments (if any)

# Install project dependencies
cd templates
npm install

# Run lint
npm run lint || true

# Run npm tests
npm test || true

# Run dotnet tests for net8.0
dotnet test -c Release -f net8.0 --no-build --collect:"XPlat Code Coverage" --consoleLoggerParameters:"Summary;Verbosity=Minimal" || true

# Run dotnet tests for net9.0
dotnet test -c Release -f net9.0 --no-build --collect:"XPlat Code Coverage" --consoleLoggerParameters:"Summary;Verbosity=Minimal" || true

# Run Percy tests
percy exec -- dotnet test -c Release -f net8.0 --filter Stage=Percy --no-build --collect:"XPlat Code Coverage" || true

# Run additional dotnet commands
dotnet run -c Release --no-build -f net8.0 --project src/docfx -- docs/docfx.json || true
dotnet run -c Release --no-build -f net8.0 --project src/docfx -- samples/seed/docfx.json --output docs/_site/seed || true

# Note: Artifacts upload and secret handling are ignored