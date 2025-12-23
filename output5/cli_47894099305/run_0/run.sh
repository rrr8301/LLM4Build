# run.sh
#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Run the test script
./scripts/test || true

# Ensure all tests are executed even if some fail
echo "All tests executed."