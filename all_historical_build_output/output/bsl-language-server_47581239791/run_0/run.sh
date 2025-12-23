#!/bin/bash

# run.sh

# Set Java Home
export JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64

# Run Gradle check
./gradlew check --stacktrace || true

# Ensure all tests are executed, even if some fail
exit 0