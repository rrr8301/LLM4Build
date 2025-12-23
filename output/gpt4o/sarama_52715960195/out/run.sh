#!/bin/bash

# Activate Go environment
export GOPATH=/go
export PATH="/usr/local/go/bin:/go/bin:${PATH}"
export CGO_ENABLED=1

# Install project dependencies
go mod download

# Create test directory if it doesn't exist
mkdir -p _test

# Run tests with JSON output and coverage
gotestsum --format testname --jsonfile _test/unittests.json -- -coverprofile=profile.out -race ./...

# Report test results
if [ -f "_test/unittests.json" ]; then
    tparse -all -format markdown -file _test/unittests.json | tee -a /dev/stdout
else
    echo "No test results found" | tee -a /dev/stdout
fi

# Report per-function test coverage
if [ -f "profile.out" ]; then
    cat >>/dev/stdout <<EOF
<details>
<summary>Click for per-func code coverage</summary>

|Filename|Function|Coverage|
|--------|--------|--------|
$(go tool cover -func=profile.out | sed -E -e 's/[[:space:]]+/|/g' -e 's/$/|/g' -e 's/^/|/g')
</details>
EOF
else
    echo "No coverage data found" | tee -a /dev/stdout
fi