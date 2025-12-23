#!/bin/bash

# Fail the script if any command fails
set -e

# Function to switch Java version
switch_java_version() {
  local version=$1
  update-alternatives --set java /usr/lib/jvm/java-${version}-openjdk-amd64/bin/java
  update-alternatives --set javac /usr/lib/jvm/java-${version}-openjdk-amd64/bin/javac
}

# Build the project with JDK 11
echo "Switching to JDK 11 for build..."
switch_java_version 11
echo "Building the project with Maven..."
mvn clean install -B -ntp -DskipTests -T1C

# Run tests with JDK 8
echo "Switching to JDK 8 for tests..."
switch_java_version 8
echo "Running tests with Maven..."
mvn install -T1C -B -ntp -fae