#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Build the project
mvn -B package --file pom.xml

# Run tests with detailed output and enable debug logging
# Add flags to skip enforcer and license checks if they were previously added
mvn test -Dsurefire.printSummary=true -Dsurefire.useFile=false -Denforcer.skip=true -Dlicense.skip=true -X

# If there are test failures, the script will exit due to 'set -e'
# You can add additional commands here if needed for further diagnostics

# Print a message indicating the tests have completed
echo "Tests completed. Check the logs above for any failures."