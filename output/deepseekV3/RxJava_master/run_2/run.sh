#!/bin/bash

# Set up environment
export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
export PATH=$JAVA_HOME/bin:$PATH

# Build the project with Java 8 toolchain
echo "Building RxJava..."
./gradlew build -Porg.gradle.java.installations.auto-download=false

# Activate Python virtual environment and run tests
echo "Running tests..."
source /venv/bin/activate

# Check if test directories exist and run tests if they do
TEST_DIRS=("tests/unit" "tests/integration" "tests/smoke" "tests/e2e")
EXISTING_DIRS=()

for dir in "${TEST_DIRS[@]}"; do
    if [ -d "$dir" ]; then
        EXISTING_DIRS+=("$dir")
    fi
done

if [ ${#EXISTING_DIRS[@]} -gt 0 ]; then
    python3 -m pytest "${EXISTING_DIRS[@]}" \
        --junitxml=junit/test-results.xml \
        --cov=./ \
        --cov-report=xml:coverage.xml
    TEST_EXIT_CODE=$?
else
    echo "No test directories found"
    TEST_EXIT_CODE=0
fi

# Output test results
echo "Test execution completed with exit code: $TEST_EXIT_CODE"

# Exit with test status
exit $TEST_EXIT_CODE