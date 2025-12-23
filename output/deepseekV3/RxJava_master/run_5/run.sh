#!/bin/bash

# Set up environment - using Java 8 from the base image
export JAVA_HOME=/opt/java/openjdk
export PATH=$JAVA_HOME/bin:$PATH

# Verify Java version
echo "Java version:"
java -version

# Build the project with Java 8
echo "Building RxJava..."
./gradlew build \
    -Porg.gradle.java.installations.auto-download=false \
    -Dorg.gradle.java.home=$JAVA_HOME \
    -Dorg.gradle.jvmargs=-Xmx2g

# Run Java tests
echo "Running Java tests..."
./gradlew test

# Activate Python virtual environment and run tests
echo "Running Python tests..."
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
    echo "No Python test directories found"
    TEST_EXIT_CODE=0
fi

# Output test results
echo "Test execution completed with exit code: $TEST_EXIT_CODE"

# Exit with test status
exit $TEST_EXIT_CODE