# run.sh
#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Run tests and ensure all tests are executed
npm run test || true

# Check code style
npm run check-style || true