#!/bin/bash

set -e

# Function to run commands and continue on error
run_command() {
    "$@" || true
}

# Install PostgreSQL 16 and extensions if not cached
if [ ! -d "$HOME/pg16" ]; then
    git clone --depth 1 --branch REL_16_STABLE https://git.postgresql.org/git/postgresql.git ~/pg16source
    cd ~/pg16source
    ./configure --prefix=$HOME/pg16 CFLAGS="-std=gnu99 -ggdb -O0" --enable-cassert --with-icu  # Added --with-icu
    make install -j$(nproc)
    cd contrib
    cd fuzzystrmatch
    make PG_CONFIG=$HOME/pg16/bin/pg_config install -j$(nproc)
    cd ../pg_trgm
    make PG_CONFIG=$HOME/pg16/bin/pg_config install -j$(nproc)
fi

# Build AGE
cd /workspace
make PG_CONFIG=$HOME/pg16/bin/pg_config install -j$(nproc)

# Pull and build pgvector
git clone https://github.com/pgvector/pgvector.git
cd pgvector
make PG_CONFIG=$HOME/pg16/bin/pg_config install -j$(nproc)

# Run regression tests
cd /workspace
run_command make PG_CONFIG=$HOME/pg16/bin/pg_config installcheck EXTRA_TESTS="pgvector fuzzystrmatch pg_trgm"

# Dump regression test errors if any
if [ -f "/workspace/regress/regression.diffs" ]; then
    echo "Dump section begin."
    cat /workspace/regress/regression.diffs
    echo "Dump section end."
    exit 1
fi