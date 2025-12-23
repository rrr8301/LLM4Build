# run.sh
#!/bin/bash

set -e

# Activate Go environment
export PATH="/usr/local/go/bin:${PATH}"

# Install project dependencies
go mod download

# Run tests
# Ensure all tests are executed, even if some fail
set +e
go test -v -race ./...
EXIT_CODE=$?
set -e

exit $EXIT_CODE