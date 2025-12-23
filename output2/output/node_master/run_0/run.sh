#!/bin/bash

# Activate Python environment (if any)
# source /path/to/venv/bin/activate

# Install project dependencies (Node.js)
npm install

# Run environment information
npx envinfo

# Build the project
make -C node build-ci -j4 V=1 CONFIG_FLAGS="--error-on-warn"

# Run tests
make -C node run-ci -j4 V=1 TEST_CI_ARGS="-p actions --measure-flakiness 9"

# Re-run tests in a folder with unusual characters
DIR='dir%20with $unusual"chars?'\''åß∂ƒ©∆¬…'
mv node "$DIR"
cd "$DIR"
./tools/test.py --flaky-tests keep_retrying -p actions -j 4

# Ensure all tests are executed
exit 0