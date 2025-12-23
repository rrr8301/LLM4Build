#!/bin/bash

# Grant execute permission for gradlew
chmod +x gradlew

# Ensure JAVA_HOME is set correctly
export JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64

# Use Java 11 for Gradle tasks
./gradlew -Dorg.gradle.java.home="$JAVA_HOME" build --stacktrace --no-daemon --no-parallel --warning-mode all