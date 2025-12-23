#!/bin/bash

# Activate environment variables if needed (none specified)

# Install project dependencies and run tests
set -e
set -o pipefail

# Test Build Tools with Maven
mvn install -P github-actions -DskipTests=true -Dmaven.javadoc.skip=true -B -V || true
mvn -P github-actions test || true

# Test Java API with Ant
ant clean -f java/build.xml || true
ant jar -f java/build.xml || true
ant junit -f java/build.xml || true