#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Function to switch Java version
switch_java_version() {
    update-alternatives --set java /usr/lib/jvm/java-$1-openjdk-amd64/bin/java
    update-alternatives --set javac /usr/lib/jvm/java-$1-openjdk-amd64/bin/javac
}

# Build the project with JDK 11
echo "Switching to JDK 11 for build..."
switch_java_version 11
./mvnw clean install -B -ntp -DskipTests -T1C

# Run tests with JDK 8
echo "Switching to JDK 8 for tests..."
switch_java_version 8
./mvnw install -T1C -B -ntp -fae