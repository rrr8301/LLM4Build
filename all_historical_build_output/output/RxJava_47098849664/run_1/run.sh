#!/bin/bash

# Grant execute permission for gradlew
chmod +x gradlew

# Use the installed Gradle version
export PATH=/opt/gradle-8.14/bin:$PATH

# Verify generated module-info
./gradlew -PjavaCompatibility=11 jar

# Build RxJava
./gradlew build --stacktrace