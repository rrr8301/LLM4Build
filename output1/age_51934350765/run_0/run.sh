#!/bin/bash

# Activate environment variables if needed (none specified)

# Build AGE
make PG_CONFIG=/usr/local/pg17/bin/pg_config install -j$(nproc)

# Pull and build pgvector
git clone https://github.com/pgvector/pgvector.git
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