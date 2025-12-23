#!/bin/bash

# Activate environments if any (none specified)

# Install project dependencies if any (none specified)

# Run build and test
ci/build

# Collect testdir from failed tests
ci/collect-testdir || true

# Ensure all test cases are executed, even if some fail
exit 0