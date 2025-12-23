#!/bin/bash

# Activate environments if needed (none in this case)

# Install project dependencies and run tests
./gradlew build coverageReport --stacktrace --scan

# Ensure all tests are executed, even if some fail
EXIT_CODE=$?
if [ $EXIT_CODE -ne 0 ]; then
  echo "Some tests failed. Exit code: $EXIT_CODE"
fi

# Exit with the original exit code
exit $EXIT_CODE