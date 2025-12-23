#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Clone the repository
git clone https://github.com/apache/flink.git
cd flink

# Remove the existing Maven wrapper to force a re-download
rm -f .mvn/wrapper/maven-wrapper.jar

# Remove the existing Maven wrapper properties to force a re-download
rm -f .mvn/wrapper/maven-wrapper.properties

# Download the Maven wrapper
./mvnw -N io.takari:maven:wrapper

# Build the project using Maven
./mvnw clean package -DskipTests -Djdk17 -Pjava17-target

# Run tests
# Ensure all tests are executed, even if some fail
set +e
./mvnw test
set -e