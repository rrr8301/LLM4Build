#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Ensure Gradle wrapper is executable
chmod +x ./gradlew

# Set JAVA_HOME environment variable
export JAVA_HOME=/usr/local/openjdk-17

# Configure Gradle to use Java 17 toolchain
echo "org.gradle.java.installations.auto-detect=false" >> gradle.properties
echo "org.gradle.java.installations.paths=$JAVA_HOME" >> gradle.properties
echo "org.gradle.java.toolchain.version=17" >> gradle.properties

# Add toolchain repository configuration to gradle.properties
echo "org.gradle.toolchains.repositories.auto-provision=true" >> gradle.properties
echo "org.gradle.toolchains.java.installations.fromEnv=JAVA_HOME" >> gradle.properties

# Ensure the build uses Java 17
echo "sourceCompatibility = '17'" >> build.gradle
echo "targetCompatibility = '17'" >> build.gradle

# Add toolchain download repository configuration
echo "org.gradle.toolchains.java.installations.auto-provision=true" >> gradle.properties
echo "org.gradle.toolchains.java.installations.repositories=https://repo.maven.apache.org/maven2" >> gradle.properties

# Build the project using Gradle
./gradlew build --no-daemon -Dorg.gradle.java.home=$JAVA_HOME --warning-mode all

# Run tests
./gradlew test --no-daemon -Dorg.gradle.java.home=$JAVA_HOME --warning-mode all