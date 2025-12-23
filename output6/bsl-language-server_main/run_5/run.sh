#!/bin/bash

set -e

# Ensure Gradle wrapper is executable
chmod +x ./gradlew

# Run Gradle build without skipping any tests
./gradlew check --stacktrace --warning-mode all