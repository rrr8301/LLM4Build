#!/bin/bash

set -e
set -o pipefail

# Ensure PostgreSQL environment variables are set
export PATH="/usr/lib/postgresql/14/bin:$PATH"
export PGDATA="/var/lib/postgresql/14/main"

# Initialize PostgreSQL database (if necessary)
if [ ! -d "$PGDATA" ]; then
    pg_ctl initdb -D "$PGDATA"
fi

# Start PostgreSQL service
pg_ctl start -D "$PGDATA" -l logfile

# Install project dependencies
make install

# Run tests
# Ensure all tests are executed, even if some fail
set +e
make test
TEST_EXIT_CODE=$?
set -e

# Stop PostgreSQL service
pg_ctl stop -D "$PGDATA"

# Exit with the test exit code
exit $TEST_EXIT_CODE