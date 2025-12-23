#!/bin/bash

set -e
set -o pipefail

# Ensure PostgreSQL environment variables are set
export PATH="/usr/lib/postgresql/14/bin:$PATH"
export PGDATA="/var/lib/postgresql/14/main"

# Initialize PostgreSQL database (if necessary)
if [ ! -d "$PGDATA" ]; then
    initdb -D "$PGDATA"
fi

# Ensure the data directory has the correct permissions
chown -R postgres:postgres "$PGDATA"

# Start PostgreSQL service
pg_ctl start -D "$PGDATA" -l /app/logfile

# Wait for PostgreSQL to start
sleep 5

# Check if PostgreSQL started successfully
if ! pg_ctl status -D "$PGDATA"; then
    echo "PostgreSQL failed to start. Check the log file for details."
    cat /app/logfile
    exit 1
fi

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