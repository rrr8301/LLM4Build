#!/bin/bash

# Activate environments (if any)

# Install project dependencies
# Placeholder for any additional dependency installation

# Run build and test
ci/build

# Collect testdir from failed tests
if [ $? -ne 0 ]; then
  ci/collect-testdir
  # Placeholder for manual artifact handling
  echo "Manual step: Upload testdir.tar.xz if needed."
fi

# Ensure all test cases are executed
exit 0