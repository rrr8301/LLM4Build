#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Function to switch Java version
switch_java_version() {
    update-alternatives --set java /usr/lib/jvm/java-$1-openjdk-amd64/bin/java
    update-alternatives --set javac /usr/lib/jvm/java-$1-openjdk-amd64/bin/javac
}

# Build the project with JDK 11
echo "Switching to JDK 11 for build..."
switch_java_version 11
./mvnw clean install -B -ntp -DskipTests -T1C

# Run tests with JDK 8
echo "Switching to JDK 8 for tests..."
switch_java_version 8
./mvnw test -T1C -B -ntp -fae -DskipEnforcer=true -Dlicense.skip=true || true

# Check for test results and handle failures
if [ -d "/app/features/sharding/core/target/surefire-reports" ]; then
    echo "Test results found. Checking for failures..."
    if grep -q "<failure" /app/features/sharding/core/target/surefire-reports/*.xml; then
        echo "Some tests failed. Please check the surefire-reports for details."
        exit 1
    else
        echo "All tests passed successfully."
    fi
else
    echo "No test results found. Please ensure tests are configured correctly."
    exit 1
fi