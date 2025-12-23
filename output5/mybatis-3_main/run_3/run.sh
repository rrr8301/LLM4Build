#!/bin/bash

# Check if the project directory exists
if [ ! -d "/app/mybatis-3" ]; then
  echo "Error: /app/mybatis-3 directory does not exist."
  exit 1
fi

# Navigate to the project directory
cd /app/mybatis-3

# Install project dependencies
mvn install -DskipTests

# Run tests, skipping those that require a Docker environment
mvn test -B -V --no-transfer-progress -Dlicense.skip=true -DskipDockerTests