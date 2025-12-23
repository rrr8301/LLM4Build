#!/bin/bash

# Build AGE
make PG_CONFIG=/pg17/bin/pg_config install -j$(nproc)

# Run regression tests (continue on error)
set +e
make PG_CONFIG=/pg17/bin/pg_config installcheck EXTRA_TESTS="pgvector fuzzystrmatch pg_trgm"
TEST_RESULT=$?

# Dump test errors if any
if [ $TEST_RESULT -ne 0 ]; then
    echo "Dump section begin."
    cat /workspace/regress/regression.diffs
    echo "Dump section end."
fi

# Exit with test result (0 if all passed, 1 if any failed)
exit $TEST_RESULT