#!/bin/bash

# Grant execute permission for gradlew
chmod +x gradlew

# Verify generated module-info
./gradlew -PjavaCompatibility=9 jar

# Build RxJava
./gradlew build --stacktrace