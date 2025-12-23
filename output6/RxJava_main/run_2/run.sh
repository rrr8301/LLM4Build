#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Run Gradle build and test with deprecation warnings enabled
./gradlew build test --no-daemon --stacktrace --info --warning-mode all

# Ensure all tests are executed, even if some fail
./gradlew test --continue --no-daemon --stacktrace --info --warning-mode all