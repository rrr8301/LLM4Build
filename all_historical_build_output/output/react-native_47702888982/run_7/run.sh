# run.sh
#!/bin/bash

# Debugging: Print the current directory and list files
echo "Current directory: $(pwd)"
echo "Listing files:"
ls -la

# Install project dependencies
# Adding verbose output for npm install to help diagnose issues
npm install --verbose || { echo "npm install failed"; exit 1; }

# Run tests
# Assuming the test-js action runs tests, we simulate this with npm test
# Ensure all tests run even if some fail
set +e
npm test
set -e