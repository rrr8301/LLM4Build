#!/bin/bash

set -e
set -o pipefail

# Activate any necessary environments (if applicable)
# source /path/to/venv/bin/activate

# Ensure PostgreSQL development headers are included
# Adjust the CFLAGS to include the necessary PostgreSQL internal headers
export CFLAGS="-I/usr/include/postgresql/14/server -I/usr/include/postgresql/internal"

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