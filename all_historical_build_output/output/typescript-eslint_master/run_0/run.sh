#!/bin/bash

# Activate environment variables if needed
export CI=true

# Install project dependencies
yarn install --immutable --inline-builds

# Build the project
yarn nx run-many --target=build --parallel --exclude=website --exclude=website-eslint

# Run all tests, ensuring all tests are executed even if some fail
set +e
yarn test-integration
yarn nx run-many --target=test --all -- --coverage
set -e

# Note: Uploading coverage to Codecov is not automated in this script.
# To upload coverage manually, use the following command:
# curl -s https://codecov.io/bash | bash -s -- -t <CODECOV_TOKEN> -f coverage/**/lcov.info -F unittest -n codecov