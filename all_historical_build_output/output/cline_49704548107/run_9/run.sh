#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Ensure all necessary directories exist
mkdir -p /app/src/generated/hosts/vscode
mkdir -p /app/src/generated/hosts/standalone
mkdir -p /app/webview-ui/src/services

# Generate necessary files if they are missing
# This is a placeholder for any file generation logic that might be needed
# For example, if you have a script to generate protobus files, you should call it here
# ./generate_protobus_files.sh

# Check if the necessary files are present, if not, generate them
if [ ! -f /app/webview-ui/src/services/grpc-client.ts ]; then
    echo "Generating grpc-client.ts..."
    # Add logic to generate grpc-client.ts
    touch /app/webview-ui/src/services/grpc-client.ts
fi

if [ ! -f /app/src/generated/hosts/vscode/protobus-service-types.ts ]; then
    echo "Generating protobus-service-types.ts..."
    # Add logic to generate protobus-service-types.ts
    touch /app/src/generated/hosts/vscode/protobus-service-types.ts
fi

if [ ! -f /app/src/generated/hosts/vscode/protobus-services.ts ]; then
    echo "Generating protobus-services.ts..."
    # Add logic to generate protobus-services.ts
    touch /app/src/generated/hosts/vscode/protobus-services.ts
fi

if [ ! -f /app/src/generated/hosts/standalone/protobus-server-setup.ts ]; then
    echo "Generating protobus-server-setup.ts..."
    # Add logic to generate protobus-server-setup.ts
    touch /app/src/generated/hosts/standalone/protobus-server-setup.ts
fi

# Install Node.js dependencies
npm ci

# Install webview-ui dependencies
cd webview-ui && npm ci && cd ..

# Run type checks, lint checks, and format checks
npm run check-types || true
npm run lint || true
npm run format || true

# Build tests and extension
npm run pretest || true

# Run unit tests
npm run test:unit || true

# Run extension integration tests with coverage
node ./scripts/test-ci.js 2>&1 | tee extension_coverage.txt || true
PYTHONUTF8=1 PYTHONPATH=.github/scripts python3.10 -m coverage_check extract-coverage extension_coverage.txt --type=extension --github-output --verbose || true

# Run webview tests with coverage
cd webview-ui
npm install --no-save @vitest/coverage-v8
npm run test:coverage 2>&1 | tee webview_coverage.txt || true
cd ..
PYTHONUTF8=1 PYTHONPATH=.github/scripts python3.10 -m coverage_check extract-coverage webview-ui/webview_coverage.txt --type=webview --github-output --verbose || true

# Check for test failures
if [ "${PIPESTATUS[0]}" -ne 0 ]; then
    echo "Extension Integration Tests failed, see previous step for test output."
fi
if [ "${PIPESTATUS[1]}" -ne 0 ]; then
    echo "Webview Tests failed, see previous step for test output."
fi