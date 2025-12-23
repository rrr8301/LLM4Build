# run.sh
#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Install project dependencies
npm install --legacy-peer-deps --force || \
    { echo "npm install failed during runtime, please check your package.json for unsupported protocols"; cat /root/.npm/_logs/*; exit 1; }

# Run tests
npm test