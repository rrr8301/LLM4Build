# run.sh
#!/bin/bash

set -e

# Activate Go environment
export PATH="/usr/local/go/bin:${PATH}"

# Download Go modules
go mod download

# Run tests
# Ensure all tests are executed, even if some fail
set +e
go test -v -race -covermode atomic -coverprofile coverage.out ./...
TEST_EXIT_CODE=$?
set -e

# Placeholder for code coverage upload
echo "Code coverage data is in coverage.out. Upload manually to Codecov."

exit $TEST_EXIT_CODE