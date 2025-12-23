# run.sh
#!/bin/bash

set -e
set -o pipefail

# Run tests
# Assuming tests are defined in a script or Makefile
# Replace `make test` with the actual test command if different
if [ -f Makefile ]; then
    make test
else
    echo "No Makefile found. Please define your test commands."
    exit 1
fi

# Run yamlfmt to format YAML files
yamlfmt .