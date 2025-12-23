#!/bin/bash

set -e

# Build mvfst
echo "Building mvfst..."
python3 build/fbcode_builder/getdeps.py --allow-system-packages build --src-dir=. mvfst --project-install-prefix mvfst:/usr/local

# Run tests (continue even if some fail)
echo "Running tests..."
set +e
python3 build/fbcode_builder/getdeps.py --allow-system-packages test --src-dir=. mvfst --project-install-prefix mvfst:/usr/local
test_exit_code=$?
set -e

# Exit with test status
exit $test_exit_code