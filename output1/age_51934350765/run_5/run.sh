#!/bin/bash

# Start PostgreSQL server
/usr/local/pg17/bin/pg_ctl -D /usr/local/pg17/data -l logfile start

# Wait for PostgreSQL to start
sleep 5

# Build AGE
make PG_CONFIG=/usr/local/pg17/bin/pg_config install -j$(nproc)

# Pull and build pgvector
if [ ! -d "pgvector" ]; then
    git clone https://github.com/pgvector/pgvector.git
fi
cd pgvector
make PG_CONFIG=/usr/local/pg17/bin/pg_config install -j$(nproc)

# Run regression tests
make PG_CONFIG=/usr/local/pg17/bin/pg_config installcheck EXTRA_TESTS="pgvector fuzzystrmatch pg_trgm" || true

# Dump regression test errors if any
if [ -f /app/regress/regression.diffs ]; then
    echo "Dump section begin."
    cat /app/regress/regression.diffs
    echo "Dump section end."
fi

# Stop PostgreSQL server
/usr/local/pg17/bin/pg_ctl -D /usr/local/pg17/data stop