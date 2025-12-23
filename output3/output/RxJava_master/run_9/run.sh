#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Ensure Gradle wrapper is executable
chmod +x ./gradlew

# Configure Gradle to use Java 11 toolchain
echo "org.gradle.java.installations.auto-detect=false" >> gradle.properties
echo "org.gradle.java.installations.paths=/usr/local/openjdk-11" >> gradle.properties

# Ensure the correct Java version is used
echo "org.gradle.java.toolchain.version=11" >> gradle.properties

# Add toolchain repository configuration to gradle.properties
echo "org.gradle.toolchains.repositories.auto-provision=true" >> gradle.properties

# Add toolchain download repository configuration
echo "org.gradle.toolchains.java.installations.fromEnv=JAVA_HOME" >> gradle.properties

# Build the project using Gradle
./gradlew build --no-daemon -Dorg.gradle.java.home=/usr/local/openjdk-11

# Run tests
./gradlew test --no-daemon -Dorg.gradle.java.home=/usr/local/openjdk-11