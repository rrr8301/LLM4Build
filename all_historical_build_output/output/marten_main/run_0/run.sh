#!/bin/bash

# Activate environments (if any specific activation is needed, add here)

# Install project dependencies
dotnet restore
npm install

# Compile the project
./build.sh compile

# Run all tests, ensuring all tests are executed even if some fail
set +e
./build.sh test-base-lib
./build.sh test-core
./build.sh test-document-db
./build.sh test-event-sourcing
./build.sh test-cli
./build.sh test-linq
./build.sh test-patching
./build.sh test-value-types
./build.sh test-code-gen
./build.sh test-noda-time
./build.sh test-aspnet-core
set -e