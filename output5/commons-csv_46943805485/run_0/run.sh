#!/bin/bash
set -e

echo "Starting Maven build..."

# Run Maven build with the same options as in GitHub Actions
mvn -Ddoclint=all --show-version --batch-mode --no-transfer-progress

echo "Build completed."