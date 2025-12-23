#!/bin/bash

# Activate environment variables
export MIMIR_VERSION=0.9.4
export MIMIR_BASEDIR=~/.mimir
export MIMIR_LOCAL=~/.mimir/local
export MAVEN_OPTS="-XX:+HeapDumpOnOutOfMemoryError -XX:HeapDumpPath=./target/java_heapdump.hprof"

# Install project dependencies and run tests
./mvnw verify -e -B -V -Prun-its,mimir || true

# Ensure all test cases are executed, even if some fail
echo "Tests completed. Check the logs for any failures."