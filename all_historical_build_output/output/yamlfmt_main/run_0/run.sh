# run.sh
#!/bin/bash

set -e
set -o pipefail

# Run tests
# Assuming tests are defined in a script or Makefile
# Replace `make test` with the actual test command if different
if [ -f Makefile ]; then
    make test || true
else
    echo "No Makefile found. Please define your test commands."
fi

# Ensure all tests are executed, even if some fail
# This is a placeholder for actual test execution logic
# Replace with actual test commands if different
yamlfmt . || true