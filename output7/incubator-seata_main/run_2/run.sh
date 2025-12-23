#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Build the project
mvn -B package --file pom.xml

# Run tests with detailed output
mvn test -Dsurefire.printSummary=true -Dsurefire.useFile=false

# If you want to see more detailed logs, you can enable debug logging
# mvn test -Dsurefire.printSummary=true -Dsurefire.useFile=false -X