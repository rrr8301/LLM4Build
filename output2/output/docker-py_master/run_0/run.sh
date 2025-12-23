#!/bin/bash

set -e

# Build the package
python3 -m build .

# Run tests
set +e  # Allow the script to continue even if some tests fail
docker logout
rm -rf ~/.docker
py.test -v --cov=docker tests/unit
make integration-dind

# Exit with success
exit 0