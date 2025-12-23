# run.sh
#!/bin/bash

# Activate environment (if any specific activation is needed, e.g., nvm, it would be here)

# Install project dependencies
npm install || { echo "npm install failed"; exit 1; }

# Run tests
# Assuming the test-js action runs tests, we simulate this with npm test
# Ensure all tests run even if some fail
set +e
npm test
set -e