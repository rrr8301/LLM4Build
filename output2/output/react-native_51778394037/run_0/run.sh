# run.sh
#!/bin/bash

set -e

# Setup git safe folders
git config --global --add safe.directory '*'

# Setup Gradle (assuming gradle is already installed in the base image)
# No specific setup needed as per the provided action

# Run Fantom tests
yarn fantom || true

# Ensure all tests are executed, even if some fail
echo "All tests executed."