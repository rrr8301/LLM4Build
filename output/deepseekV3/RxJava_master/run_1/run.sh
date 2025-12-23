#!/bin/bash

# Set up environment
export JAVA_HOME=/opt/java/openjdk
export PATH=$JAVA_HOME/bin:$PATH

# Build the project
echo "Building RxJava..."
./gradlew build

# Activate Python virtual environment and run tests
echo "Running tests..."
source /venv/bin/activate && \
python3 -m pytest tests/unit tests/integration tests/smoke tests/e2e \
    --junitxml=junit/test-results.xml \
    --cov=./ \
    --cov-report=xml:coverage.xml

# Capture exit code from tests
TEST_EXIT_CODE=$?

# Output test results
echo "Test execution completed with exit code: $TEST_EXIT_CODE"

# Exit with test status
exit $TEST_EXIT_CODE