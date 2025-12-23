#!/bin/bash

# Install project dependencies
make install_tools

# Check license headers
make addlicense_check

# Run Go Vet
make vet

# Run tests
set +e  # Continue on errors
make test_v
make integrationtest
set -e  # Stop on errors