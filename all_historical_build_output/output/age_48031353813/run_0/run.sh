# run.sh
#!/bin/bash

set -e

# Get latest commit id of PostgreSQL 17
PG_COMMIT_HASH=$(git ls-remote https://git.postgresql.org/git/postgresql.git refs/heads/REL_17_STABLE | awk '{print $1}')

# Install PostgreSQL 17 and some extensions
if [ ! -d "$HOME/pg17" ]; then
    git clone --depth 1 --branch REL_17_STABLE https://git.postgresql.org/git/postgresql.git ~/pg17source
    cd ~/pg17source
    ./configure --prefix=$HOME/pg17 CFLAGS="-std=gnu99 -ggdb -O0" --enable-cassert
    make install -j$(nproc)
    cd contrib
    cd fuzzystrmatch
    make PG_CONFIG=$HOME/pg17/bin/pg_config install -j$(nproc)
    cd ../pg_trgm
    make PG_CONFIG=$HOME/pg17/bin/pg_config install -j$(nproc)
fi

# Build AGE
make PG_CONFIG=$HOME/pg17/bin/pg_config install -j$(nproc)

# Pull and build pgvector
git clone https://github.com/pgvector/pgvector.git
cd pgvector
make PG_CONFIG=$HOME/pg17/bin/pg_config install -j$(nproc)

# Run regression tests
set +e
make PG_CONFIG=$HOME/pg17/bin/pg_config installcheck EXTRA_TESTS="pgvector fuzzystrmatch pg_trgm"
TEST_RESULT=$?
set -e

# Dump regression test errors if any
if [ $TEST_RESULT -ne 0 ]; then
    echo "Dump section begin."
    cat $HOME/work/age/age/regress/regression.diffs
    echo "Dump section end."
    exit 1
fi