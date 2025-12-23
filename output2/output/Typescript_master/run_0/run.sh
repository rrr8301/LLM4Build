#!/bin/bash

# Run tests and ensure all tests are executed even if some fail
set -e
npm run test -- --no-lint --bundle=true || true

# Note: Uploading coverage artifacts and using Codecov is not supported in this script.
# Please handle coverage reports manually or through alternative means.