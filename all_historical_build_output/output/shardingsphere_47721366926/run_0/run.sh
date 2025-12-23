#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Function to run a command and continue even if it fails
run_command() {
    "$@" || true
}

# Build the project with JDK 11
echo "Setting up JDK 11 for build..."
export JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64
export PATH=$JAVA_HOME/bin:$PATH
echo "Building project with Maven..."
run_command ./mvnw clean install -B -ntp -DskipTests -T1C

# Run tests with JDK 8
echo "Setting up JDK 8 for tests..."
export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
export PATH=$JAVA_HOME/bin:$PATH
echo "Running tests with Maven..."
run_command ./mvnw install -T1C -B -ntp -fae