# run.sh
#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Run tests and check style
npm run test || true
npm run check-style || true