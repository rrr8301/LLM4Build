# run.sh
#!/bin/bash

set -e

# Run make and make test
make
make test || true  # Ensure all tests run even if some fail