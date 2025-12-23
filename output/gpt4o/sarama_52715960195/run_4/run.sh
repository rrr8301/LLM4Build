#!/bin/bash

# Activate Go environment
export PATH="/usr/local/go/bin:/go/bin:${PATH}"
export GOPATH=/go
export GOTOOLCHAIN=local

# Install project dependencies
go mod download

# Create test directory if it doesn't exist
mkdir -p _test

# Run tests with coverage
gotestsum --jsonfile _test/unittests.json -- -coverprofile=_test/profile.out ./...

# Report test results
tparse -all -format markdown -file _test/unittests.json | tee -a /dev/null

# Report per-function test coverage
cat >>/dev/null <<EOF
<details>
<summary>Click for per-func code coverage</summary>

|Filename|Function|Coverage|
|--------|--------|--------|
$(go tool cover -func=_test/profile.out | sed -E -e 's/[[:space:]]+/|/g' -e 's/$/|/g' -e 's/^/|/g')
</details>
EOF