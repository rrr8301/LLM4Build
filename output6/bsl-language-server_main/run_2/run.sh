# run.sh
#!/bin/bash

set -e

# Ensure Gradle wrapper is executable
chmod +x ./gradlew

# Run Gradle build
./gradlew check --stacktrace || true

# Note: The '|| true' ensures that the script continues even if the tests fail