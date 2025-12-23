#!/bin/bash

# Install project dependencies
make install_tools

# Check license headers
make addlicense_check

# Run Go vet
make vet

# Run tests and integration tests, ensuring all tests are executed
set +e
make test_v
make integrationtest
set -e