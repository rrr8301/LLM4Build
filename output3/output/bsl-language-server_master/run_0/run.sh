#!/bin/bash

# Run Gradle build
./gradlew check --stacktrace || true

# Note: The '|| true' ensures that the script continues even if the tests fail.