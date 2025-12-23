#!/bin/bash

set -e
set -o pipefail

# Build the project
CGO_ENABLED=0 go build ./...
go install ./tools/build_gcsfuse
build_gcsfuse . /tmp ${GITHUB_SHA}

# Run tests with coverage
CGO_ENABLED=0 go test -p 1 -count 1 -covermode=atomic -coverprofile=coverage.out -coverpkg=./... -v -skip $(cat flaky_tests.lst | go run tools/scripts/skip_tests/main.go) $(go list ./...)

# Run race detector tests
go test -p 1 -count 1 -v -race -skip $(cat flaky_tests.lst | go run tools/scripts/skip_tests/main.go) ./internal/cache/... ./internal/gcsx/...

# Placeholder for uploading coverage reports
echo "Upload coverage reports manually using the coverage.out file."