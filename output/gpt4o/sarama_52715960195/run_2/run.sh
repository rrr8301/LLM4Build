#!/bin/bash

# Activate Go environment
export PATH="/usr/local/go/bin:${PATH}"
export GOPATH=/go
export GOTOOLCHAIN=local

# Install project dependencies
go mod download

# Run tests
make test

# Report test results
go run github.com/mfridman/tparse@v0.18.0 -all -format markdown -file _test/unittests.json | tee -a /dev/null

# Report per-function test coverage
cat >>/dev/null <<EOF
<details>
<summary>Click for per-func code coverage</summary>

|Filename|Function|Coverage|
|--------|--------|--------|
$(go tool cover -func=profile.out | sed -E -e 's/[[:space:]]+/|/g' -e 's/$/|/g' -e 's/^/|/g')
</details>
EOF