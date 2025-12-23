# run.sh
#!/bin/bash

set -e

# Set Go version
export GO_VERSION=1.24.x

# Activate Go environment
export PATH="/usr/local/go/bin:${PATH}"

# Download Go modules
go mod download

# Run tests
set +e
go test -v -race -covermode atomic -coverprofile coverage.out ./...
TEST_EXIT_CODE=$?
set -e

# Provide instructions for uploading code coverage
echo "To upload code coverage, use the following command:"
echo "curl -s https://codecov.io/bash | bash -s -- -t <CODECOV_TOKEN> -f coverage.out"

exit $TEST_EXIT_CODE