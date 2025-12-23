# run.sh
#!/bin/bash

set -e

# Activate Go environment
export PATH="/usr/local/go/bin:${PATH}"

# Install Go modules
go mod tidy

# Run tests
set +e
make vet
make test_v
make integrationtest