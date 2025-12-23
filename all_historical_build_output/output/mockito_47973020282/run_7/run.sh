#!/bin/bash

set -e

# Activate environment variables if needed
export JAVA_HOME=/opt/java/openjdk
export PATH="$JAVA_HOME/bin:$PATH"

# Install project dependencies
./gradlew --no-daemon --warning-mode all build

# Run tests and ensure all tests are executed
set +e
./gradlew --no-daemon --warning-mode all test
TEST_EXIT_CODE=$?

# Generate coverage report
./gradlew --no-daemon --warning-mode all jacocoTestReport

# Print test reports for debugging
if [ $TEST_EXIT_CODE -ne 0 ]; then
    echo "Tests failed. Printing test reports for debugging:"
    find . -type f -name "*.html" -exec echo "Report: {}" \;
    find . -type f -name "*.html" -exec cat {} \;
fi

# Exit with the test exit code
exit $TEST_EXIT_CODE