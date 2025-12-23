#!/bin/bash

# Fail on any error
set -e

# Install dependencies (without running tests)
mvn -B dependency:go-offline test clean -U --quiet --fail-never -DskipTests=true -f build-pom.xml

# Run tests (continue even if some fail)
mvn -B verify -U --fail-at-end -Dsource.skip=true -Dmaven.javadoc.skip=true -f build-pom.xml