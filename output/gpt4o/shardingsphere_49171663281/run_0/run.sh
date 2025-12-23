#!/bin/bash

# Activate JDK 11 for build
export JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64
export PATH=$JAVA_HOME/bin:$PATH

# Build the project with Maven
./mvnw clean install -B -ntp -DskipTests -T1C

# Activate JDK 8 for testing
export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
export PATH=$JAVA_HOME/bin:$PATH

# Run tests with Maven, ensuring all tests are executed
./mvnw install -T1C -B -ntp -fae