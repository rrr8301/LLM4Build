#!/bin/bash

# Activate any necessary environments (none needed for Java)

# Check if the .git directory exists and has commits
if [ -d ".git" ] && [ -n "$(git rev-parse HEAD 2>/dev/null)" ]; then
    echo "Git repository is initialized and has commits."
else
    echo "Error: .git directory is missing or has no commits."
    exit 1
fi

# Install project dependencies using Maven
./mvnw clean install -B -V --no-transfer-progress -D"license.skip=true" -Denforcer.skip=true

# Run tests with Maven, ensuring all tests are executed
set +e
./mvnw test -B -V --no-transfer-progress -D"license.skip=true" -Denforcer.skip=true $TEST_CONTAINERS_PROFILE
set -e