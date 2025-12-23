#!/bin/bash

set -e
set -o pipefail

# Activate any necessary environments (if applicable)
# source /path/to/venv/bin/activate

# Ensure PostgreSQL development headers are included
export CFLAGS="-I/usr/include/postgresql/14/server"

# Build the project
make install

# Run tests
# Assuming tests are run using a make target or a script
# Ensure all tests run even if some fail
set +e
make test
TEST_EXIT_CODE=$?
set -e

# Exit with the test exit code
exit $TEST_EXIT_CODE