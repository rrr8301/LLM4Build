#!/bin/bash

# Activate Go environment
export PATH="/usr/local/go/bin:${PATH}"

# Install project dependencies
make deps

# Run tests
make test || true

# Report test results
go run github.com/mfridman/tparse@v0.18.0 -all -format markdown -file _test/unittests.json | tee -a /app/test_summary.md

# Report per function test coverage
cat >>/app/test_summary.md <<EOF
<details>
<summary>Click for per-func code coverage</summary>

|Filename|Function|Coverage|
|--------|--------|--------|
$(go tool cover -func=profile.out | sed -E -e 's/[[:space:]]+/|/g' -e 's/$/|/g' -e 's/^/|/g')
</details>
EOF