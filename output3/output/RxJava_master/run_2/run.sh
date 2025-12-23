#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Ensure Gradle wrapper is executable
chmod +x ./gradlew

# Configure Gradle to use Java 11 toolchain
echo "org.gradle.java.installations.auto-detect=false" >> gradle.properties
echo "org.gradle.java.installations.paths=/usr/lib/jvm/java-11-openjdk-amd64" >> gradle.properties

# Build the project using Gradle
./gradlew build --no-daemon

# Run tests
./gradlew test --no-daemon