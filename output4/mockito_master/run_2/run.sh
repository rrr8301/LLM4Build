#!/bin/bash

# Ensure gradlew is executable
chmod +x ./gradlew

# Activate environment variables if any

# Install project dependencies
# Assuming dependencies are managed by Gradle, no additional steps needed

# Build and run tests
./gradlew build --stacktrace --scan

# Generate coverage report
./gradlew coverageReport --stacktrace --scan

# Placeholder for manual upload of coverage report
echo "Coverage report generated. Please upload manually if needed."

# Ensure all tests are executed
set +e
./gradlew test --continue