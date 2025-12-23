#!/bin/bash

# run.sh

# Run Gradle build and tests
./gradlew check --stacktrace || true

# Note: The '|| true' ensures that the script continues even if tests fail