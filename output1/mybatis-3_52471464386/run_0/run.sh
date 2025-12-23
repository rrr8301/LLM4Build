#!/bin/bash

# Activate any necessary environments (none needed for Java)

# Install project dependencies using Maven
./mvnw clean install -DskipTests

# Run tests with Maven, ensuring all tests are executed
set +e  # Continue on error
./mvnw test -B -V --no-transfer-progress -D"license.skip=true" -PtestContainers
set -e  # Stop on error